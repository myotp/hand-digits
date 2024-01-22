defmodule HandDigits.Examples do
  def demo() do
    {images, _labels} = HandDigits.MnistData.load_mnist()

    images
    |> HandDigits.Model.transform_images()
    |> Nx.slice_along_axis(0, 1)
    |> Nx.reshape({1, 1, 28, 28})
    |> Nx.to_heatmap()
  end

  def demo2() do
    {_images, labels} = HandDigits.MnistData.load_mnist()
    {binary, type, _} = labels

    binary
    |> Nx.from_binary(type)
    |> Nx.new_axis(-1)
    |> Nx.slice_along_axis(0, 1)
  end

  def demo3() do
    {_images, labels} = HandDigits.MnistData.load_mnist()

    labels
    |> HandDigits.Model.transform_labels()
    |> Nx.slice_along_axis(0, 1)
  end
end
