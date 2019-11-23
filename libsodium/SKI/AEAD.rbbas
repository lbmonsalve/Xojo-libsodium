#tag Module
Protected Module AEAD
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_aes256gcm_decrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Reserved As Ptr, CipherText As Ptr, CipherTextSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_aes256gcm_encrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Message As Ptr, MessageSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Reserved As Ptr, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_chacha20poly1305_decrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Reserved As Ptr, CipherText As Ptr, CipherTextSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_chacha20poly1305_encrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Message As Ptr, MessageSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Reserved As Ptr, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_chacha20poly1305_ietf_decrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Reserved As Ptr, CipherText As Ptr, CipherTextSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_chacha20poly1305_ietf_encrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferSize As UInt64, Message As Ptr, MessageSize As UInt64, AdditionalData As Ptr, AdditionalDataSize As UInt64, Reserved As Ptr, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_xchacha20poly1305_ietf_decrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferLength As UInt64, nsec As Ptr, Message As Ptr, MessageLength As UInt64, AddicionalData As Ptr, AdicionalDataLength As UInt64, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function crypto_aead_xchacha20poly1305_ietf_encrypt Lib "libsodium" (Buffer As Ptr, ByRef BufferLength As UInt64, Message As Ptr, MessageLength As UInt64, AddicionalData As Ptr, AdicionalDataLength As UInt64, nsec As Ptr, Nonce As Ptr, SecretKey As Ptr) As Int32
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function DecryptData(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, AdditionalData As MemoryBlock, Type As AEADType = AEADType.ChaCha20Poly1305) As MemoryBlock
		  ' Authenticated Encryption with Additional Data (AEAD) verifies that the CipherText includes a valid
		  ' message authentication code using the SecretKey, a public nonce, and optional additional data. If
		  ' the verification succeeds, the function returns the decrypted message. On error returns Nil.
		  
		  Select Case Type
		  Case AEADType.ChaCha20Poly1305
		    Return DecryptData_ChaCha20Poly1305(CipherText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.ChaCha20Poly1305_IETF
		    Return DecryptData_ChaCha20Poly1305_IETF(CipherText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.XChaCha20Poly1305_IETF
		    Return DecryptData_XChaCha20Poly1305_IETF(CipherText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.AES256GCM
		    Return DecryptData_AES256GCM(CipherText, Key, Nonce, AdditionalData)
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecryptData_AES256GCM(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  'Static HasAES256GCM As Boolean = libsodium.Version.HasAES256GCM
		  'If Not HasAES256GCM Then Raise New PlatformNotSupportedException
		  
		  CheckSize(Key.Value, crypto_aead_aes256gcm_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_aes256gcm_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(CipherText.Size - crypto_aead_aes256gcm_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_aes256gcm_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		      AdditionalData, AdditionalData.Size, Nonce, Key.Value) <> 0 Then Return Nil
		    Else
		      If crypto_aead_aes256gcm_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		        Nil, 0, Nonce, Key.Value) <> 0 Then Return Nil
		      End If
		      Return buffer.StringValue(0, buffersz)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecryptData_ChaCha20Poly1305(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_chacha20poly1305_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_chacha20poly1305_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(CipherText.Size - crypto_aead_chacha20poly1305_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_chacha20poly1305_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		      AdditionalData, AdditionalData.Size, Nonce, Key.Value) <> 0 Then Return Nil
		    Else
		      If crypto_aead_chacha20poly1305_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		        Nil, 0, Nonce, Key.Value) <> 0 Then Return Nil
		      End If
		      Return buffer.StringValue(0, buffersz)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecryptData_ChaCha20Poly1305_IETF(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_chacha20poly1305_IETF_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_chacha20poly1305_IETF_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(CipherText.Size - crypto_aead_aes256gcm_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_chacha20poly1305_ietf_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		      AdditionalData, AdditionalData.Size, Nonce, Key.Value) <> 0 Then Return Nil
		    Else
		      If crypto_aead_chacha20poly1305_ietf_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		        Nil, 0, Nonce, Key.Value) <> 0 Then Return Nil
		      End If
		      Return buffer.StringValue(0, buffersz)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecryptData_XChaCha20Poly1305_IETF(CipherText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_xchacha20poly1305_ietf_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_xchacha20poly1305_ietf_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(CipherText.Size - crypto_aead_xchacha20poly1305_ietf_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_xchacha20poly1305_ietf_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		      AdditionalData, AdditionalData.Size, Nonce, Key.Value) <> 0 Then Return Nil
		    Else
		      If crypto_aead_xchacha20poly1305_ietf_decrypt(Buffer, buffersz, Nil, CipherText, CipherText.Size, _
		        Nil, 0, Nonce, Key.Value) <> 0 Then Return Nil
		      End If
		      Return buffer.StringValue(0, buffersz)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncryptData(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, AdditionalData As MemoryBlock, Type As AEADType = AEADType.ChaCha20Poly1305) As MemoryBlock
		  ' Authenticated Encryption with Additional Data (AEAD) encrypts the ClearText using a secret key
		  ' and public nonce. A message authentication code for both the encrypted message and the optional
		  ' AdditionalData is computed and prepended to the encrypted message. AdditionalData may be Nil
		  ' if no additional data are required.
		  '
		  ' The public nonce should never ever be reused with the same key. The recommended way to generate
		  ' it is to use libsodium.RandomBytes for the first message, and increment it for each subsequent
		  ' message using the same key.
		  
		  Select Case Type
		  Case AEADType.ChaCha20Poly1305
		    Return EncryptData_ChaCha20Poly1305(ClearText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.ChaCha20Poly1305_IETF
		    Return EncryptData_ChaCha20Poly1305_IETF(ClearText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.XChaCha20Poly1305_IETF
		    Return EncryptData_XChaCha20Poly1305_IETF(ClearText, Key, Nonce, AdditionalData)
		    
		  Case AEADType.AES256GCM
		    Return EncryptData_AES256GCM(ClearText, Key, Nonce, AdditionalData)
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncryptData_AES256GCM(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  Static HasAES256GCM As Boolean = libsodium.Configuration.HasAES256GCM
		  If Not HasAES256GCM Then Raise New PlatformNotSupportedException
		  
		  CheckSize(Key.Value, crypto_aead_aes256gcm_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_aes256gcm_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(ClearText.Size + crypto_aead_aes256gcm_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_aes256gcm_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		      AdditionalData, AdditionalData.Size, Nil, Nonce, Key.Value) = 0 Then Return buffer
		    Else
		      If crypto_aead_aes256gcm_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		        Nil, 0, Nil, Nonce, Key.Value) = 0 Then Return buffer
		      End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncryptData_ChaCha20Poly1305(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_chacha20poly1305_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_chacha20poly1305_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(ClearText.Size + crypto_aead_chacha20poly1305_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_chacha20poly1305_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		      AdditionalData, AdditionalData.Size, Nil, Nonce, Key.Value) = 0 Then Return buffer
		    Else
		      If crypto_aead_chacha20poly1305_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		        Nil, 0, Nil, Nonce, Key.Value) = 0 Then Return buffer
		      End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncryptData_ChaCha20Poly1305_IETF(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_chacha20poly1305_IETF_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_chacha20poly1305_IETF_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(ClearText.Size + crypto_aead_chacha20poly1305_IETF_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_chacha20poly1305_ietf_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		      AdditionalData, AdditionalData.Size, Nil, Nonce, Key.Value) = 0 Then Return buffer
		    Else
		      If crypto_aead_chacha20poly1305_ietf_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		        Nil, 0, Nil, Nonce, Key.Value) = 0 Then Return buffer
		      End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EncryptData_XChaCha20Poly1305_IETF(ClearText As MemoryBlock, Key As libsodium.SKI.SecretKey, Nonce As MemoryBlock, ByRef AdditionalData As MemoryBlock) As MemoryBlock
		  CheckSize(Key.Value, crypto_aead_xchacha20poly1305_ietf_KEYBYTES)
		  CheckSize(Nonce, crypto_aead_xchacha20poly1305_ietf_NPUBBYTES)
		  
		  Dim buffer As New MemoryBlock(ClearText.Size + crypto_aead_xchacha20poly1305_ietf_ABYTES)
		  Dim buffersz As UInt64 = buffer.Size
		  
		  If AdditionalData <> Nil Then
		    If crypto_aead_xchacha20poly1305_ietf_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		      AdditionalData, AdditionalData.Size, Nil, Nonce, Key.Value) = 0 Then Return buffer
		    Else
		      If crypto_aead_xchacha20poly1305_ietf_encrypt(buffer, buffersz, ClearText, ClearText.Size, _
		        Nil, 0, Nil, Nonce, Key.Value) = 0 Then Return buffer
		      End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Function Generate(constructionType As AEADType = AEADType.ChaCha20Poly1305) As libsodium.SKI.SecretKey
		  ' Returns unpredictable bytes that are suitable to be used as a secret key.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libsodium/wiki/libsodium.SKI.SecretKey.Generate
		  
		  If constructionType= AEADType.ChaCha20Poly1305 Then
		    Return New libsodium.SKI.SecretKey(RandomBytes(crypto_aead_chacha20poly1305_KEYBYTES))
		  ElseIf constructionType= AEADType.ChaCha20Poly1305_IETF Then
		    Return New libsodium.SKI.SecretKey(RandomBytes(crypto_aead_chacha20poly1305_ietf_KEYBYTES))
		  ElseIf constructionType= AEADType.XChaCha20Poly1305_IETF Then
		    Return New libsodium.SKI.SecretKey(RandomBytes(crypto_aead_xchacha20poly1305_ietf_KEYBYTES))
		  ElseIf constructionType= AEADType.AES256GCM Then
		    Return New libsodium.SKI.SecretKey(RandomBytes(crypto_aead_aes256gcm_KEYBYTES))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RandomNonce(Type As AEADType = AEADType.ChaCha20Poly1305) As MemoryBlock
		  Select Case Type
		  Case AEADType.ChaCha20Poly1305
		    Return RandomBytes(crypto_aead_chacha20poly1305_NPUBBYTES)
		    
		  Case AEADType.ChaCha20Poly1305_IETF
		    Return RandomBytes(crypto_aead_chacha20poly1305_IETF_NPUBBYTES)
		    
		  Case AEADType.XChaCha20Poly1305_IETF
		    Return RandomBytes(crypto_aead_xchacha20poly1305_IETF_NPUBBYTES)
		    
		  Case AEADType.AES256GCM
		    Return RandomBytes(crypto_aead_aes256gcm_NPUBBYTES)
		    
		  End Select
		End Function
	#tag EndMethod


	#tag Note, Name = What is AEAD?
		Authenticated Encryption with Additional Data (AEAD) encrypts the ClearText using a secret key and public nonce. A message 
		authentication code for both the encrypted message and the optional, unencrypted additional data is computed and prepended to the 
		encrypted message. 
		
		A typical use case for additional data is to store protocol-specific metadata about the message, such as its length and encoding.
		
		The public nonce should never ever be reused with the same key. The recommended way to generate it is to use libsodium.RandomBytes 
		for the first message, and increment it for each subsequent message using the same key.
	#tag EndNote


	#tag Enum, Name = AEADType, Flags = &h1
		ChaCha20Poly1305
		  ChaCha20Poly1305_IETF
		  XChaCha20Poly1305_IETF
		AES256GCM
	#tag EndEnum


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