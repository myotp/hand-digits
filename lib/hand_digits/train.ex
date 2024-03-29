defmodule HandDigits.Train do
  def train() do
    {images, labels} = HandDigits.MnistData.load_mnist()

    images =
      images
      |> HandDigits.Model.transform_images()
      |> Nx.to_batched(32)
      |> Enum.to_list()

    labels =
      labels
      |> HandDigits.Model.transform_labels()
      |> Nx.to_batched(32)
      |> Enum.to_list()

    data = Enum.zip(images, labels)

    training_count = floor(0.8 * Enum.count(data))
    validation_count = floor(0.2 * training_count)

    {training_data, test_data} = Enum.split(data, training_count)
    {validation_data, training_data} = Enum.split(training_data, validation_count)

    model = HandDigits.Model.new({1, 28, 28})

    Mix.Shell.IO.info("training...")

    state = HandDigits.Model.train(model, training_data, validation_data)

    Mix.Shell.IO.info("testing...")

    HandDigits.Model.test(model, state, test_data)

    HandDigits.Model.save!(model, state)

    :ok
  end
end
