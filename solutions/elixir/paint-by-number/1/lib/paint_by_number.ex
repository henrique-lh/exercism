defmodule PaintByNumber do
  @base 2

  def palette_bit_size(color_count, total_bits \\ 1) do
    total_number_of_representations = @base ** total_bits

    cond do
      total_number_of_representations < color_count ->
        palette_bit_size(color_count, total_bits + 1)

      true ->
        total_bits
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    total_bits = palette_bit_size(color_count)
    <<first_pixel::size(total_bits), _rest::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    total_bits = palette_bit_size(color_count)
    <<_first_pixel::size(total_bits), rest_pixels::bitstring>> = picture
    rest_pixels
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
