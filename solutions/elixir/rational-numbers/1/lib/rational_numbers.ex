defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    numerator = a1 * b2 + a2 * b1
    denominator = b1 * b2
    gcd = Integer.gcd(numerator, denominator)
    cond do
      numerator == 0 -> {numerator, 1}
      denominator < 0 -> {div((-1 * numerator), gcd), div((-1 * denominator), gcd)}
      true -> {div(numerator, gcd), div(denominator, gcd)}
    end
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    numerator = a1 * b2 - a2 * b1
    denominator = b1 * b2
    gcd = Integer.gcd(numerator, denominator)
    cond do
      numerator == 0 -> {numerator, 1}
      denominator < 0 -> {div((-1 * numerator), gcd), div((-1 * denominator), gcd)}
      true -> {div(numerator, gcd), div(denominator, gcd)}
    end
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    numerator = a1 * a2
    denominator = b1 * b2
    gcd = Integer.gcd(numerator, denominator)
    cond do
      numerator == 0 -> {numerator, 1}
      denominator < 0 -> {div((-1 * numerator), gcd), div((-1 * denominator), gcd)}
      true -> {div(numerator, gcd), div(denominator, gcd)}
    end
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, b :: rational) :: rational
  def divide_by(a, b) do
    {a1, b1} = a
    {a2, b2} = b
    numerator = a1 * b2
    denominator = a2 * b1
    IO.puts("num = #{numerator} den = #{denominator}")
    gcd = Integer.gcd(numerator, denominator)
    IO.puts("gcd=#{gcd}")
    cond do
      numerator == 0 -> {numerator, 1}
      denominator < 0 -> {div((-1 * numerator), gcd), div((-1 * denominator), gcd)}
      true -> {div(numerator, gcd), div(denominator, gcd)}
    end
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    {num, den} = a
    gcd = Integer.gcd(num, den)
    {Kernel.abs(div(num, gcd)), Kernel.abs(div(den, gcd))}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    {num, den} = cond do
      n > 0 -> {elem(a, 0), elem(a, 1)}
      n < 0 -> {elem(a, 1), elem(a, 0)}
      n == 0 -> {1, 1}
    end
    {num, den} = cond do
      den < 0 -> {num * -1, den * -1}
      true -> {num, den}
    end
    IO.puts("num = #{num} den = #{den}")
    gcd = Integer.gcd(num, den)
    {div(trunc(:math.pow(num, Kernel.abs(n))), gcd), div(trunc(:math.pow(den, Kernel.abs(n))), gcd)}
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {num, den} = cond do
      n > 0 -> {elem(n, 0), elem(n, 1)}
      n < 0 -> {elem(n, 1), elem(n, 0)}
      n == 0 -> {1, 1}
    end
    {num, den} = cond do
      den < 0 -> {num * -1, den * -1}
      true -> {num, den}
    end
    :math.pow(:math.pow(x, num), 1/den)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    {num, den} = a
    {num, den} = cond do
      den < 0 -> {num * -1, den * -1}
      true -> {num, den}
    end
    gcd = Integer.gcd(num, den)
    {div(num, gcd), div(den, gcd)}
  end
end

IO.inspect(RationalNumbers.pow_rational({3, 5}, -2))
