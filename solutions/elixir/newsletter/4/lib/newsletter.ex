defmodule Newsletter do
  def read_emails(path) do
    {:ok, emails} = File.read(path)
    String.split(emails, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.write(pid, email)
    IO.write(pid, "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_file = open_log(log_path)

    Enum.each(emails, fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(log_file, email)
        :error -> :ok
      end
    end)

    close_log(log_file)
  end
end
