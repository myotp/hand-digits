defmodule HandDigits.MnistData do
  def load_mnist() do
    if !File.exists?(path()) do
      save_mnist()
    end

    load!()
  end

  defp save_mnist do
    HandDigits.Model.download()
    |> save!()
  end

  defp save!(data) do
    contents = :erlang.term_to_binary(data)

    File.write!(path(), contents)
  end

  defp load! do
    path()
    |> File.read!()
    |> :erlang.binary_to_term()
  end

  defp path do
    Path.join(Application.app_dir(:hand_digits, "priv"), "mnist.axon")
  end
end
