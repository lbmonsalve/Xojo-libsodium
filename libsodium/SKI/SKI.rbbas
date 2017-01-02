#tag Module
Protected Module SKI
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_auth Lib "libsodium" (Buffer As Ptr, Message As Ptr, MessageLength As UInt64, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_auth_verify Lib "libsodium" (Signature As Ptr, Message As Ptr, MessageLength As UInt64, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_secretbox_easy Lib "libsodium" (Buffer As Ptr, Message As Ptr, MessageLength As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_secretbox_open_easy Lib "libsodium" (Buffer As Ptr, Message As Ptr, MessageLength As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function DecryptData(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock) As MemoryBlock
		  ' Decrypts the CipherText using the XSalsa20 stream cipher with the specified Key and Nonce. A
		  ' Poly1305 message authentication code is prepended by the EncryptData method and will be 
		  ' validated by this method. The decrypted data is returned on success. On error returns Nil.
		  ' See: https://download.libsodium.org/doc/secret-key_cryptography/authenticated_encryption.html#combined-mode
		  
		  CheckSize(Nonce, crypto_secretbox_NONCEBYTES)
		  
		  Dim buffer As New MemoryBlock(CipherText.Size - crypto_secretbox_MACBYTES)
		  If crypto_secretbox_open_easy(Buffer, CipherText, CipherText.Size, Nonce, Key.Value) = 0 Then
		    Return buffer
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncryptData(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock) As MemoryBlock
		  ' Encrypts the ClearText using the XSalsa20 stream cipher with the specified Key and Nonce. A
		  ' Poly1305 message authentication code is also generated and prepended to the returned encrypted
		  ' data. On error returns Nil.
		  ' See: https://download.libsodium.org/doc/secret-key_cryptography/authenticated_encryption.html#combined-mode
		  
		  CheckSize(Nonce, crypto_secretbox_NONCEBYTES)
		  'If Key.Value.Size <> crypto_secretbox_KEYBYTES Then Raise New SodiumException(ERR_SIZE_MISMATCH)
		  
		  Dim buffer As New MemoryBlock(ClearText.Size + crypto_secretbox_MACBYTES)
		  If crypto_secretbox_easy(buffer, ClearText, ClearText.Size, Nonce, Key.Value) = 0 Then 
		    Return buffer
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateMAC(Message As MemoryBlock, Key As libsodium.SKI.SecretKey) As MemoryBlock
		  ' Generate a HMAC-SHA512256 authentication code for the Message using SecretKey.
		  ' See: https://download.libsodium.org/doc/secret-key_cryptography/secret-key_authentication.html
		  
		  'If Key.Value.Size <> crypto_auth_KEYBYTES Then Raise New SodiumException(ERR_SIZE_MISMATCH)
		  
		  Dim signature As New MemoryBlock(crypto_auth_BYTES)
		  If crypto_auth(signature, Message, Message.Size, Key.Value) = 0 Then
		    Return signature
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RandomKey() As libsodium.SKI.SecretKey
		  ' Returns random bytes that are suitable to be used as a secret key.
		  
		  Return New libsodium.SKI.SecretKey(RandomBytes(crypto_secretbox_KEYBYTES))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VerifyMAC(MAC As MemoryBlock, Message As MemoryBlock, Key As libsodium.SKI.SecretKey) As Boolean
		  ' Validate a HMAC-SHA512256 authentication code for the Message that was generated using SecretKey
		  ' See: https://download.libsodium.org/doc/secret-key_cryptography/secret-key_authentication.html
		  
		  'If Key.Value.Size <> crypto_auth_KEYBYTES Then Raise New SodiumException(ERR_SIZE_MISMATCH)
		  
		  Return crypto_auth_verify(MAC, Message, Message.Size, Key.Value) = 0
		End Function
	#tag EndMethod


	#tag Constant, Name = crypto_secretbox_KEYBYTES, Type = Double, Dynamic = False, Default = \"32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = crypto_secretbox_MACBYTES, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = crypto_secretbox_NONCEBYTES, Type = Double, Dynamic = False, Default = \"24", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
