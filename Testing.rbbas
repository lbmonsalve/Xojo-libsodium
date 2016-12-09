#tag Module
Protected Module Testing
	#tag Method, Flags = &h21
		Private Sub Assert(b As Boolean)
		  If Not b Then Raise New RuntimeException
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTests() As Boolean
		  TestResult = 0
		  Try
		    TestPKIEncrypt()
		  Catch
		    TestResult = 1
		    Return False
		  End Try
		  
		  Try
		    TestPKISign()
		  Catch
		    TestResult = 2
		    Return False
		  End Try
		  
		  Try
		    TestPKIOther()
		  Catch
		    TestResult = 3
		    Return False
		  End Try
		  '
		  'Try
		  'TestMultiHandle()
		  'Catch
		  'TestResult = 4
		  'Return False
		  'End Try
		  '
		  'Try
		  'TestCookieEngine()
		  'Catch
		  'TestResult = 5
		  'Return False
		  'End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestPKIEncrypt()
		  Dim senderkey As libsodium.PKI.EncryptionKey = libsodium.PKI.EncryptionKey.Generate()
		  Dim recipkey As libsodium.PKI.EncryptionKey = libsodium.PKI.EncryptionKey.Derive(libsodium.PKI.RandomKey)
		  Dim nonce As MemoryBlock = libsodium.PKI.RandomNonce
		  
		  Dim msg1 As String = "This is a test message."
		  Dim crypted As String = libsodium.PKI.EncryptData(msg1, recipkey.PublicKey, senderkey, nonce)
		  Dim msg2 As String = libsodium.PKI.DecryptData(crypted, senderkey.PublicKey, recipkey, nonce)
		  
		  Assert(msg1 = msg2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestPKIOther()
		  Dim msg As String = "This is a test message."
		  Assert(libsodium.EncodeHex(msg) = EncodeHex(msg))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestPKISign()
		  Dim senderkey As libsodium.PKI.SigningKey = libsodium.PKI.SigningKey.Generate()
		  
		  Dim msg As String = "This is a test message."
		  Dim sig As String = libsodium.PKI.SignData(msg, senderkey.PrivateKey)
		  Assert(libsodium.PKI.VerifyData(sig, senderkey.PublicKey))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected TestResult As Integer
	#tag EndProperty


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
