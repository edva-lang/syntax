defmodule SyntaxGallery.Crypto do
  @moduledoc """
  Cryptographic hashing and payload signing helpers.
  """

  @hash_algorithm :sha256

  @spec sign_payload(binary(), binary()) :: {:ok, binary()} | {:error, atom()}
  def sign_payload(payload, secret_key) when is_binary(payload) and is_binary(secret_key) do
    signature =
      :crypto.mac(:hmac, @hash_algorithm, secret_key, payload)
      |> Base.encode16(case: :lower)

    {:ok, signature}
  end

  def sign_payload(_invalid, _secret), do: {:error, :invalid_payload}
end
