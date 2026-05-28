defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_seconds 31_557_600
  @earth_to_earth_years 1.0
  @mercury_to_earth_years 0.2408467
  @venus_to_earth_years 0.61519726
  @mars_to_earth_years 1.8808158
  @jupiter_to_earth_years 11.862615
  @saturn_to_earth_years 29.447498
  @uranus_to_earth_years 84.016846
  @neptune_to_earth_years 164.79132

  defp to_earth_years(seconds), do: seconds / @earth_seconds

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :earth, do: {:ok, to_earth_years(seconds) / @earth_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :mercury, do: {:ok, to_earth_years(seconds) / @mercury_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :venus, do: {:ok, to_earth_years(seconds) / @venus_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :mars, do: {:ok, to_earth_years(seconds) / @mars_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :jupiter, do: {:ok, to_earth_years(seconds) / @jupiter_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :saturn, do: {:ok, to_earth_years(seconds) / @saturn_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :uranus, do: {:ok, to_earth_years(seconds) / @uranus_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet === :neptune, do: {:ok, to_earth_years(seconds) / @neptune_to_earth_years}

  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(_, _), do: {:error, "not a planet"}

end
