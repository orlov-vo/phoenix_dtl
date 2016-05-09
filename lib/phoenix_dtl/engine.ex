defmodule PhoenixDtl.Engine do
  @behaviour Phoenix.Template.Engine

  @doc """
  Precompiles the String file_path into a function defintion, using erlydtl engine
  """
  def compile(path, _name) do
    path
    |> read
    |> EEx.compile_string(engine: Phoenix.HTML.Engine, file: path, line: 1)
  end

  def read(file_path) do
    module_name = file_path_to_module_name(file_path)
    result = :erlydtl.compile_file(String.to_char_list(file_path), module_name, [{:binary, true}, {:out_dir, false}])
    binary = case result do
      {:ok, _module, binary} -> binary
      {:ok, _module, binary, _warnings} -> binary
      :error -> raise Phoenix.Template.UndefinedError
      {:error, errors, _warnings} -> raise Phoenix.Template.UndefinedError, message: errors
    end
  end

  defp sha256(str) do
    hash = :crypto.hash(:sha256, str)
    hex = for <<b <- hash>>, do: :io_lib.format("~2.16.0b", [b])
    List.flatten(hex)
  end

  defp file_path_to_module_name(file_path) do
    hash = sha256(file_path)
    :"template_#{hash}"
  end

  defp engine_for(name) do
    case Phoenix.Template.format_encoder(name) do
      Phoenix.HTML.Engine -> Phoenix.HTML.Engine
      _                   -> EEx.SmartEngine
    end
  end
end
