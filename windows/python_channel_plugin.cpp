#include "python_channel_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#include <codecvt>
#include <locale>
#include <map>
#include <stdlib.h>
#include <filesystem>
#include <format>
#include <vector>
#include <string>
#include <thread>

namespace python_channel
{

  // static
  void PythonChannelPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "python_channel",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<PythonChannelPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  PythonChannelPlugin::PythonChannelPlugin() {}

  PythonChannelPlugin::~PythonChannelPlugin() {}

  void PythonChannelPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {

    const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());

    if (method_call.method_name().compare("getPlatformVersion") == 0)
    {
      std::ostringstream version_stream;
      version_stream << "Windows ";
      if (IsWindows10OrGreater())
      {
        version_stream << "10+";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }
      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if (method_call.method_name().compare("setenv") == 0)
    {
      std::string path;
      std::string env;

      if (arguments)
      {
        auto path_it = arguments->find(flutter::EncodableValue("path"));
        if (path_it != arguments->end())
        {
          path = std::get<std::string>(path_it->second);
        }
        auto env_it = arguments->find(flutter::EncodableValue("env"));
        if (env_it != arguments->end())
        {
          env = std::get<std::string>(env_it->second);
        }

        result->Success(flutter::EncodableValue(_putenv_s(path.c_str(), env.c_str())));
      }
    }
    else
    {
      result->NotImplemented();
    }
  }

} // namespace python_channel
