// Code generated by protoc-gen-go. DO NOT EDIT.
// source: common.proto

package common

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	math "math"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

// The request message.
type RequestMnemonic struct {
	Mnemonic             string   `protobuf:"bytes,1,opt,name=mnemonic,proto3" json:"mnemonic,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *RequestMnemonic) Reset()         { *m = RequestMnemonic{} }
func (m *RequestMnemonic) String() string { return proto.CompactTextString(m) }
func (*RequestMnemonic) ProtoMessage()    {}
func (*RequestMnemonic) Descriptor() ([]byte, []int) {
	return fileDescriptor_555bd8c177793206, []int{0}
}

func (m *RequestMnemonic) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_RequestMnemonic.Unmarshal(m, b)
}
func (m *RequestMnemonic) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_RequestMnemonic.Marshal(b, m, deterministic)
}
func (m *RequestMnemonic) XXX_Merge(src proto.Message) {
	xxx_messageInfo_RequestMnemonic.Merge(m, src)
}
func (m *RequestMnemonic) XXX_Size() int {
	return xxx_messageInfo_RequestMnemonic.Size(m)
}
func (m *RequestMnemonic) XXX_DiscardUnknown() {
	xxx_messageInfo_RequestMnemonic.DiscardUnknown(m)
}

var xxx_messageInfo_RequestMnemonic proto.InternalMessageInfo

func (m *RequestMnemonic) GetMnemonic() string {
	if m != nil {
		return m.Mnemonic
	}
	return ""
}

// The request message.
type Request struct {
	SecretKey            string   `protobuf:"bytes,1,opt,name=secret_key,json=secretKey,proto3" json:"secret_key,omitempty"`
	Did                  string   `protobuf:"bytes,2,opt,name=did,proto3" json:"did,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Request) Reset()         { *m = Request{} }
func (m *Request) String() string { return proto.CompactTextString(m) }
func (*Request) ProtoMessage()    {}
func (*Request) Descriptor() ([]byte, []int) {
	return fileDescriptor_555bd8c177793206, []int{1}
}

func (m *Request) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Request.Unmarshal(m, b)
}
func (m *Request) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Request.Marshal(b, m, deterministic)
}
func (m *Request) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Request.Merge(m, src)
}
func (m *Request) XXX_Size() int {
	return xxx_messageInfo_Request.Size(m)
}
func (m *Request) XXX_DiscardUnknown() {
	xxx_messageInfo_Request.DiscardUnknown(m)
}

var xxx_messageInfo_Request proto.InternalMessageInfo

func (m *Request) GetSecretKey() string {
	if m != nil {
		return m.SecretKey
	}
	return ""
}

func (m *Request) GetDid() string {
	if m != nil {
		return m.Did
	}
	return ""
}

// The response message
type Response struct {
	ApiKey               string   `protobuf:"bytes,1,opt,name=api_key,json=apiKey,proto3" json:"api_key,omitempty"`
	StatusMessage        string   `protobuf:"bytes,2,opt,name=status_message,json=statusMessage,proto3" json:"status_message,omitempty"`
	Status               bool     `protobuf:"varint,3,opt,name=status,proto3" json:"status,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *Response) Reset()         { *m = Response{} }
func (m *Response) String() string { return proto.CompactTextString(m) }
func (*Response) ProtoMessage()    {}
func (*Response) Descriptor() ([]byte, []int) {
	return fileDescriptor_555bd8c177793206, []int{2}
}

func (m *Response) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_Response.Unmarshal(m, b)
}
func (m *Response) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_Response.Marshal(b, m, deterministic)
}
func (m *Response) XXX_Merge(src proto.Message) {
	xxx_messageInfo_Response.Merge(m, src)
}
func (m *Response) XXX_Size() int {
	return xxx_messageInfo_Response.Size(m)
}
func (m *Response) XXX_DiscardUnknown() {
	xxx_messageInfo_Response.DiscardUnknown(m)
}

var xxx_messageInfo_Response proto.InternalMessageInfo

func (m *Response) GetApiKey() string {
	if m != nil {
		return m.ApiKey
	}
	return ""
}

func (m *Response) GetStatusMessage() string {
	if m != nil {
		return m.StatusMessage
	}
	return ""
}

func (m *Response) GetStatus() bool {
	if m != nil {
		return m.Status
	}
	return false
}

func init() {
	proto.RegisterType((*RequestMnemonic)(nil), "common.RequestMnemonic")
	proto.RegisterType((*Request)(nil), "common.Request")
	proto.RegisterType((*Response)(nil), "common.Response")
}

func init() { proto.RegisterFile("common.proto", fileDescriptor_555bd8c177793206) }

var fileDescriptor_555bd8c177793206 = []byte{
	// 262 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0x9c, 0x91, 0x41, 0x4b, 0xc3, 0x40,
	0x10, 0x85, 0x4d, 0x0b, 0xdb, 0x64, 0x50, 0x5b, 0xe7, 0x60, 0x43, 0x40, 0x28, 0x01, 0xa1, 0x17,
	0x8b, 0xe8, 0x49, 0x4f, 0x16, 0x0f, 0x25, 0x94, 0x42, 0xc9, 0x1f, 0x28, 0xdb, 0x74, 0x90, 0x20,
	0xbb, 0x1b, 0x33, 0xdb, 0x43, 0xae, 0xfe, 0x72, 0x69, 0x76, 0xa9, 0x12, 0x3d, 0x48, 0x6f, 0xf3,
	0xbe, 0x99, 0xf7, 0x26, 0x93, 0x85, 0xf3, 0xc2, 0x28, 0x65, 0xf4, 0xac, 0xaa, 0x8d, 0x35, 0x28,
	0x9c, 0x4a, 0xef, 0x60, 0x98, 0xd3, 0xc7, 0x9e, 0xd8, 0xae, 0x34, 0x29, 0xa3, 0xcb, 0x02, 0x13,
	0x08, 0x95, 0xaf, 0xe3, 0x60, 0x12, 0x4c, 0xa3, 0xfc, 0xa8, 0xd3, 0x67, 0x18, 0xf8, 0x71, 0xbc,
	0x01, 0x60, 0x2a, 0x6a, 0xb2, 0x9b, 0x77, 0x6a, 0xfc, 0x60, 0xe4, 0xc8, 0x92, 0x1a, 0x1c, 0x41,
	0x7f, 0x57, 0xee, 0xe2, 0x5e, 0xcb, 0x0f, 0x65, 0xba, 0x85, 0x30, 0x27, 0xae, 0x8c, 0x66, 0xc2,
	0x31, 0x0c, 0x64, 0x55, 0xfe, 0x70, 0x0a, 0x59, 0x95, 0x07, 0xdb, 0x2d, 0x5c, 0xb2, 0x95, 0x76,
	0xcf, 0x1b, 0x45, 0xcc, 0xf2, 0x8d, 0x7c, 0xc2, 0x85, 0xa3, 0x2b, 0x07, 0xf1, 0x1a, 0x84, 0x03,
	0x71, 0x7f, 0x12, 0x4c, 0xc3, 0xdc, 0xab, 0x87, 0xcf, 0x1e, 0x88, 0xd7, 0xf6, 0x32, 0xcc, 0x20,
	0x59, 0x90, 0xa6, 0x5a, 0x5a, 0x9a, 0xaf, 0xb3, 0xee, 0x91, 0xe3, 0x99, 0xff, 0x1d, 0x9d, 0x46,
	0x32, 0xfa, 0x6e, 0xb8, 0x6f, 0x4d, 0xcf, 0xf0, 0x09, 0xf0, 0x77, 0x14, 0x0e, 0x3b, 0x11, 0x7f,
	0x5a, 0x5f, 0xe0, 0x6a, 0x41, 0x76, 0xbe, 0xce, 0x96, 0xd4, 0x9c, 0xb6, 0xfc, 0x1e, 0xa2, 0x63,
	0xc2, 0xbf, 0x76, 0x6e, 0x45, 0xfb, 0xc4, 0x8f, 0x5f, 0x01, 0x00, 0x00, 0xff, 0xff, 0x94, 0x82,
	0x36, 0x59, 0xf2, 0x01, 0x00, 0x00,
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion4

// CommonClient is the client API for Common service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type CommonClient interface {
	GenerateAPIRequestMnemonic(ctx context.Context, in *RequestMnemonic, opts ...grpc.CallOption) (*Response, error)
	GenerateAPIRequest(ctx context.Context, in *Request, opts ...grpc.CallOption) (*Response, error)
	GetAPIKeyMnemonic(ctx context.Context, in *RequestMnemonic, opts ...grpc.CallOption) (*Response, error)
	GetAPIKey(ctx context.Context, in *Request, opts ...grpc.CallOption) (*Response, error)
}

type commonClient struct {
	cc *grpc.ClientConn
}

func NewCommonClient(cc *grpc.ClientConn) CommonClient {
	return &commonClient{cc}
}

func (c *commonClient) GenerateAPIRequestMnemonic(ctx context.Context, in *RequestMnemonic, opts ...grpc.CallOption) (*Response, error) {
	out := new(Response)
	err := c.cc.Invoke(ctx, "/common.Common/GenerateAPIRequestMnemonic", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *commonClient) GenerateAPIRequest(ctx context.Context, in *Request, opts ...grpc.CallOption) (*Response, error) {
	out := new(Response)
	err := c.cc.Invoke(ctx, "/common.Common/GenerateAPIRequest", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *commonClient) GetAPIKeyMnemonic(ctx context.Context, in *RequestMnemonic, opts ...grpc.CallOption) (*Response, error) {
	out := new(Response)
	err := c.cc.Invoke(ctx, "/common.Common/GetAPIKeyMnemonic", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *commonClient) GetAPIKey(ctx context.Context, in *Request, opts ...grpc.CallOption) (*Response, error) {
	out := new(Response)
	err := c.cc.Invoke(ctx, "/common.Common/GetAPIKey", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// CommonServer is the server API for Common service.
type CommonServer interface {
	GenerateAPIRequestMnemonic(context.Context, *RequestMnemonic) (*Response, error)
	GenerateAPIRequest(context.Context, *Request) (*Response, error)
	GetAPIKeyMnemonic(context.Context, *RequestMnemonic) (*Response, error)
	GetAPIKey(context.Context, *Request) (*Response, error)
}

// UnimplementedCommonServer can be embedded to have forward compatible implementations.
type UnimplementedCommonServer struct {
}

func (*UnimplementedCommonServer) GenerateAPIRequestMnemonic(ctx context.Context, req *RequestMnemonic) (*Response, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GenerateAPIRequestMnemonic not implemented")
}
func (*UnimplementedCommonServer) GenerateAPIRequest(ctx context.Context, req *Request) (*Response, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GenerateAPIRequest not implemented")
}
func (*UnimplementedCommonServer) GetAPIKeyMnemonic(ctx context.Context, req *RequestMnemonic) (*Response, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetAPIKeyMnemonic not implemented")
}
func (*UnimplementedCommonServer) GetAPIKey(ctx context.Context, req *Request) (*Response, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetAPIKey not implemented")
}

func RegisterCommonServer(s *grpc.Server, srv CommonServer) {
	s.RegisterService(&_Common_serviceDesc, srv)
}

func _Common_GenerateAPIRequestMnemonic_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(RequestMnemonic)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommonServer).GenerateAPIRequestMnemonic(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/common.Common/GenerateAPIRequestMnemonic",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommonServer).GenerateAPIRequestMnemonic(ctx, req.(*RequestMnemonic))
	}
	return interceptor(ctx, in, info, handler)
}

func _Common_GenerateAPIRequest_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Request)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommonServer).GenerateAPIRequest(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/common.Common/GenerateAPIRequest",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommonServer).GenerateAPIRequest(ctx, req.(*Request))
	}
	return interceptor(ctx, in, info, handler)
}

func _Common_GetAPIKeyMnemonic_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(RequestMnemonic)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommonServer).GetAPIKeyMnemonic(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/common.Common/GetAPIKeyMnemonic",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommonServer).GetAPIKeyMnemonic(ctx, req.(*RequestMnemonic))
	}
	return interceptor(ctx, in, info, handler)
}

func _Common_GetAPIKey_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Request)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommonServer).GetAPIKey(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/common.Common/GetAPIKey",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommonServer).GetAPIKey(ctx, req.(*Request))
	}
	return interceptor(ctx, in, info, handler)
}

var _Common_serviceDesc = grpc.ServiceDesc{
	ServiceName: "common.Common",
	HandlerType: (*CommonServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "GenerateAPIRequestMnemonic",
			Handler:    _Common_GenerateAPIRequestMnemonic_Handler,
		},
		{
			MethodName: "GenerateAPIRequest",
			Handler:    _Common_GenerateAPIRequest_Handler,
		},
		{
			MethodName: "GetAPIKeyMnemonic",
			Handler:    _Common_GetAPIKeyMnemonic_Handler,
		},
		{
			MethodName: "GetAPIKey",
			Handler:    _Common_GetAPIKey_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "common.proto",
}
