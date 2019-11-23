#tag Window
Begin ContainerControl libsodiumTestPanel
   AcceptFocus     =   ""
   AcceptTabs      =   True
   AutoDeactivate  =   True
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   Enabled         =   True
   EraseBackground =   True
   HasBackColor    =   False
   Height          =   300
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   ""
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   ""
   UseFocusRing    =   ""
   Visible         =   True
   Width           =   300
   Begin BevelButton BevelButton1
      AcceptFocus     =   False
      AutoDeactivate  =   True
      BackColor       =   "&c00000000"
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "Test"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   30
      HelpTag         =   ""
      Icon            =   ""
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   ""
      TextUnit        =   0
      Top             =   0
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   60
   End
   Begin TextArea TextArea1
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   258
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   0
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   16
      TextUnit        =   0
      Top             =   42
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   300
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

#tag Events BevelButton1
	#tag Event
		Sub Action()
		  TextArea1.AppendText "libsodium version: "+ libsodium.Configuration.VersionString+ EndOfLine+ EndOfLine
		  
		  
		  'TextArea1.AppendText "Read secure memory..."+ EndOfLine
		  'Dim mb As New SecureMemoryBlock(64) ' allocate 64 bytes
		  'mb.CString(0) = "Hello, world!"
		  'TextArea1.AppendText mb.CString(0)+ EndOfLine ' read data
		  'TextArea1.AppendText EndOfLine
		  
		  
		  'TextArea1.AppendText "Password hashing/Verify a hash"+ EndOfLine
		  'Dim pw As libsodium.Password = "seekrit"
		  'Dim hash As String = pw.GenerateHash()
		  'If pw.VerifyHash(hash) Then
		  'TextArea1.AppendText "verify a password: OK "+ "hash: """+ hash+ """"+ EndOfLine
		  'Else
		  'TextArea1.AppendText "Bad password!"
		  'End If
		  'TextArea1.AppendText EndOfLine
		  
		  
		  'TextArea1.AppendText "Generic hashing/BLAKE2b:"+ EndOfLine
		  'Dim f As FolderItem = GetOpenFolderItem("")
		  'If f Is Nil Then
		  'TextArea1.AppendText "no file!"+ EndOfLine
		  'Else
		  'Dim bs As BinaryStream = BinaryStream.Open(f)
		  'Dim h As New libsodium.GenericHashDigest()
		  'Do Until bs.EOF
		  'h.Process(bs.Read(4096))
		  'Loop
		  'Dim hashValue As String= libsodium.EncodeHex(h.Value)
		  'TextArea1.AppendText f.Name+ " hash: "+ hashValue+ EndOfLine
		  'End If
		  'TextArea1.AppendText EndOfLine
		  
		  
		  'TextArea1.AppendText "Generic hashing/SHA512:"+ EndOfLine
		  'f= GetOpenFolderItem("")
		  'If f Is Nil Then
		  'TextArea1.AppendText "no file!"+ EndOfLine
		  'Else
		  'Dim bs As BinaryStream = BinaryStream.Open(f)
		  'Dim h As New libsodium.GenericHashDigest(libsodium.HashType.SHA512)
		  'Do Until bs.EOF
		  'h.Process(bs.Read(4096))
		  'Loop
		  'Dim hashValue As String= libsodium.EncodeHex(h.Value)
		  'TextArea1.AppendText f.Name+ " hash: "+ hashValue+ EndOfLine
		  'End If
		  'TextArea1.AppendText EndOfLine
		  
		  
		  Const kHelloWorld= "Hello, world!"
		  
		  'TextArea1.AppendText "PKI Encryption:"+ EndOfLine
		  'TextArea1.AppendText "Key exchange: X25519, Encryption: XSalsa20, Signatures: Ed25519, Authentication: Poly1305 MAC"+ EndOfLine
		  '// Generate a new random encryption key:
		  'Dim key As libsodium.PKI.EncryptionKey
		  'key = key.Generate()
		  '
		  '// Generate a new encryption key from a seed:
		  'key = key.Generate(key.RandomSeed)
		  '
		  '// Generate a new encryption key from a password (PBKDF2):
		  'Dim passwd As libsodium.Password = "seekritpassword"
		  'key= New libsodium.PKI.EncryptionKey(passwd, passwd.RandomSalt, libsodium.ResourceLimits.Interactive)
		  '
		  '// Encrypt data:
		  'Dim mykey As libsodium.PKI.EncryptionKey
		  'mykey = mykey.Generate() ' random key for example
		  'Dim theirkey As New libsodium.PKI.ForeignKey(mykey.Generate) ' the recipient's public key, random for example
		  '
		  'Dim nonce As MemoryBlock = mykey.RandomNonce ' must be stored/sent with the message
		  '
		  'Dim crypttext As MemoryBlock = libsodium.PKI.EncryptData(kHelloWorld, theirkey, mykey, nonce)
		  '
		  '// Decrypt data
		  'Dim cleartext As MemoryBlock = libsodium.PKI.DecryptData(crypttext, theirkey, mykey, nonce)
		  '
		  'If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		  'TextArea1.AppendText "ok!"+ EndOfLine
		  'Else
		  'TextArea1.AppendText "no match!"+ EndOfLine
		  'End If
		  'TextArea1.AppendText EndOfLine
		  '
		  'TextArea1.AppendText "PKI Encryption/Calculate the shared key:"+ EndOfLine
		  'mykey = mykey.Generate() ' random key for example
		  'Dim sharedkey As New libsodium.PKI.SharedSecret(theirkey, mykey)
		  'Call sharedkey.Export SpecialFolder.Desktop.Child("sharedkey.key"), Nil, True
		  'TextArea1.AppendText "ok!"+ EndOfLine
		  'TextArea1.AppendText EndOfLine
		  '
		  'TextArea1.AppendText "PKI Encryption/Public-key authenticated encryption:"+ EndOfLine
		  'Dim alice_secretkey As New libsodium.PKI.EncryptionKey(passwd, passwd.RandomSalt, libsodium.ResourceLimits.Interactive)
		  'Dim alice_publickey As New libsodium.PKI.ForeignKey(alice_secretkey)
		  'Dim alice_publickeyExport As String= alice_publickey.Export
		  '
		  'Dim bob_secretkey As New libsodium.PKI.EncryptionKey(passwd, passwd.RandomSalt, libsodium.ResourceLimits.Interactive)
		  'Dim bob_secretkeyExport As String= bob_secretkey.Export // JUST TEST, DON'T DO IT!!
		  'Dim bob_publickey As New libsodium.PKI.ForeignKey(bob_secretkey)
		  'Dim bob_publickeyExport As String= bob_publickey.Export
		  '
		  '// exchange public keys...
		  'Dim bob_publickey_exchange As libsodium.PKI.ForeignKey= libsodium.PKI.ForeignKey.Import(bob_publickeyExport)
		  'Dim alice_publickey_exchange As libsodium.PKI.ForeignKey= libsodium.PKI.ForeignKey.Import(alice_publickeyExport)
		  '
		  'crypttext= libsodium.PKI.EncryptData(kHelloWorld, bob_publickey_exchange, alice_secretkey, nonce)
		  'cleartext= libsodium.PKI.DecryptData(crypttext, alice_publickey_exchange, bob_secretkey, nonce)
		  '
		  'If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		  'TextArea1.AppendText "ok!"+ EndOfLine
		  'Else
		  'TextArea1.AppendText "no match!"+ EndOfLine
		  'End If
		  'TextArea1.AppendText EndOfLine
		  'Break
		  
		  
		  TextArea1.AppendText "SKI Encryption AEAD:"+ EndOfLine
		  
		  If libsodium.Configuration.HasAES256GCM Then
		    TextArea1.AppendText "AES256GCM:"+ EndOfLine
		    Dim key As libsodium.SKI.SecretKey
		    key = libsodium.SKI.AEAD.Generate(libsodium.SKI.AEAD.AEADType.AES256GCM) ' random key for example
		    Dim nonce As MemoryBlock = libsodium.SKI.AEAD.RandomNonce(libsodium.SKI.AEAD.AEADType.AES256GCM) ' must be stored/sent with the message
		    Dim ciphertext As MemoryBlock = libsodium.SKI.AEAD.EncryptData(kHelloWorld, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.AES256GCM)
		    Dim cleartext As MemoryBlock = libsodium.SKI.AEAD.DecryptData(ciphertext, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.AES256GCM)
		    
		    If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		      TextArea1.AppendText "ok!"+ EndOfLine
		    Else
		      TextArea1.AppendText "no match!"+ EndOfLine
		    End If
		    
		  End If
		  
		  TextArea1.AppendText "ChaCha20Poly1305:"+ EndOfLine
		  Dim key As libsodium.SKI.SecretKey = libsodium.SKI.AEAD.Generate ' random key for example
		  Dim nonce As MemoryBlock = libsodium.SKI.AEAD.RandomNonce ' must be stored/sent with the message
		  
		  Dim ciphertext As MemoryBlock = libsodium.SKI.AEAD.EncryptData(kHelloWorld, key, nonce, "123456")
		  Dim cleartext As MemoryBlock = libsodium.SKI.AEAD.DecryptData(ciphertext, key, nonce, "123456")
		  
		  If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		    TextArea1.AppendText "ok!"+ EndOfLine
		  Else
		    TextArea1.AppendText "no match!"+ EndOfLine
		  End If
		  
		  TextArea1.AppendText "ChaCha20Poly1305_IETF:"+ EndOfLine
		  key = libsodium.SKI.AEAD.Generate(libsodium.SKI.AEAD.AEADType.ChaCha20Poly1305_IETF) ' random key for example
		  nonce = libsodium.SKI.AEAD.RandomNonce(libsodium.SKI.AEAD.AEADType.ChaCha20Poly1305_IETF) ' must be stored/sent with the message
		  ciphertext = libsodium.SKI.AEAD.EncryptData(kHelloWorld, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.ChaCha20Poly1305_IETF)
		  cleartext = libsodium.SKI.AEAD.DecryptData(ciphertext, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.ChaCha20Poly1305_IETF)
		  
		  If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		    TextArea1.AppendText "ok!"+ EndOfLine
		  Else
		    TextArea1.AppendText "no match!"+ EndOfLine
		  End If
		  
		  
		  TextArea1.AppendText "XChaCha20Poly1305_IETF:"+ EndOfLine
		  key = libsodium.SKI.AEAD.Generate(libsodium.SKI.AEAD.AEADType.XChaCha20Poly1305_IETF) ' random key for example
		  nonce = libsodium.SKI.AEAD.RandomNonce(libsodium.SKI.AEAD.AEADType.XChaCha20Poly1305_IETF) ' must be stored/sent with the message
		  ciphertext = libsodium.SKI.AEAD.EncryptData(kHelloWorld, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.XChaCha20Poly1305_IETF)
		  cleartext = libsodium.SKI.AEAD.DecryptData(ciphertext, key, nonce, "123456", libsodium.SKI.AEAD.AEADType.XChaCha20Poly1305_IETF)
		  
		  If cleartext.StringValue(0, cleartext.Size)= kHelloWorld Then
		    TextArea1.AppendText "ok!"+ EndOfLine
		  Else
		    TextArea1.AppendText "no match!"+ EndOfLine
		  End If
		  
		  Dim keyExport As String= key.Export
		  Dim keyValue As MemoryBlock= key.Value
		  Dim keyImport As New libsodium.SKI.SecretKey(keyValue)
		  
		  If key= keyImport Then TextArea1.AppendText "key= keyImport, ok!"+ EndOfLine
		  
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents