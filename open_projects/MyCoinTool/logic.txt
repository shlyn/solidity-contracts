# Palkeoramix decompiler. 

const unknown4ed74332 = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e
const XEN = 0x6450dee7fd2fb8e39061434babcfc05599a6fb8

def storage:
  unknown0a473c2b is mapping of uint256 at storage 0

def unknown0a473c2b(uint256 _param1): # not payable
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown0a473c2b[_param1]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def unknown9a97880c(uint256 _param1, uint256 _param2, uint256 _param3): # not payable
  require calldata.size - 4 >=ΓÇ▓ 96
  require _param1 == addr(_param1)
  require _param2 == addr(_param2)
  return addr(sha3(0, addr(_param1), sha3(addr(_param1), addr(_param2), 'execute_proxy', _param3), sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0)))

def unknownb7595c3b(array _param1, uint256 _param2): # not payable
  require calldata.size - 4 >=ΓÇ▓ 64
  require _param1 <= 18446744073709551615
  require _param1 + 35 <ΓÇ▓ calldata.size
  if _param1.length > 18446744073709551615:
      revert with 0, 65
  if ceil32(_param1.length) + 128 < 96 or ceil32(_param1.length) + 128 > 18446744073709551615:
      revert with 0, 65
  require _param1 + _param1.length + 36 <= calldata.size
  create2 contract with 0 wei
                  salt: _param2
                  code: _param1[all]
  require ext_code.size(create2.new_address)
  mem[ceil32(_param1.length) + 128] = addr(create2.new_address)
  return Mask(8 * -ceil32(_param1.length) + _param1.length + 32, 0, 0), 
         mem[_param1.length + 160 len -_param1.length + ceil32(_param1.length)]

def unknownfbf551ad(uint256 _param1, uint256 _param2): # not payable
  require calldata.size - 4 >=ΓÇ▓ 64
  require _param1 == addr(_param1)
  if not _param2:
      return addr(sha3(0, 0, addr(_param1), 128))
  if _param2 <= 127:
      return addr(sha3(0, 0, addr(_param1), uint8(_param2)))
  if _param2 <= 255:
      return addr(sha3(0, 0, addr(_param1), 0, uint8(_param2)))
  if _param2 <= 65535:
      return addr(sha3(0, 0, a
      return addr(shddr(_param1), 0, uint16(_param2)))
  if _param2 > 16777215:a3(0, 0, addr(_param1), 0, uint32(_param2)))
  return addr(sha3(0, 0, addr(_param1), 0, _param2 % 16777216))

def unknownbb739814(uint256 _param1, uint256 _param2) payable: 
  require calldata.size - 4 >=ΓÇ▓ 64
  mem[0] = caller
  mem[32] = 0
  if unknown0a473c2b[caller] > !_param1:
      revert with 0, 17
  if var32002 >= unknown0a473c2b[caller] + _param1:
      if unknown0a473c2b[caller] > !_param1:
          revert with 0, 17
      unknown0a473c2b[caller] += _param1
      stop
  mem[var38001] = addr(this.address)
  mem[var38001 + 20] = caller
  mem[var38001 + 40] = 'execute_proxy' << 152
  mem[var38001 + 53] = var38002
  mem[96] = var40001 - 128
  mem[64] = var40001
  mem[0] = 0x3d602d80600a3d3981f3363d3d373d3d3d363d731bc8f1
  mem[32] = 0x24e7e320c71a6394de0458e8d7ea27623e5af43d82803e903d91602b57fd5bf3
  create2 contract with 0 wei
                  salt: var42001
                  code: 0x3d602d80600a3d3981f3363d3d373d3d3d363d731bc8f1, 0x24e7e320c71a6394de0458e8d7ea27623e5af43d82803e903d91602b57fd5bf3
  if not addr(create2.new_address):
      revert with 0, 'ERC1167: create2 failed'
  mem[var40001] = 0xf3efc26000000000000000000000000000000000000000000000000000000000
  mem[var52001] = _param2
  mem[var52001 + 32] = var52002
  require ext_code.size(addr(create2.new_address))
  call addr(create2.new_address).mem[var56004 len 4] with:
       gas gas_remaining wei
      args mem[var56004 + 4 len var56005 - 4]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  if var60001 == -1:
      revert with 0, 17
  ...  # Decompilation aborted, sorry: ("decompilation didn't finish",)

def unknownc8785396(uint256 _param1, uint256 _param2, uint256 _param3) payable: 
  mem[64] = 96
  require not call.value
  require calldata.size - 4 >=ΓÇ▓ 96
  require _param3 == addr(_param3)
  idx = _param1
  while idx < _param2:
      _10 = mem[64]
      mem[mem[64] + 32] = addr(this.address)
      mem[mem[64] + 52] = caller
      mem[mem[64] + 72] = 'execute_proxy' << 152
      mem[mem[64] + 85] = idx
      _11 = mem[64]
      mem[mem[64]] = 85
      mem[64] = mem[64] + 117
      _13 = sha3(mem[_11 + 32 len mem[_11]])
      mem[_10 + 205] = sha3(mem[_11 + 32 len mem[_11]])
      mem[_10 + 237] = sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0)
      mem[_10 + 117] = 0xc027186600000000000000000000000000000000000000000000000000000000
      mem[_10 + 121] = addr(_param3)
      mem[_10 + 153] = 100
      mem[_10 + 185] = idx
      require ext_code.size(addr(sha3(0, this.address, _13, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))))
      call addr(sha3(0, this.address, _13, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))).0xc0271866 with:
           gas gas_remaining wei
          args addr(_param3), 100, idx
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      if idx == -1:
          revert with 0, 17
      idx = idx + 1
      continue 

def unknown18a74fc0() payable: 
  require calldata.size - 4 >=ΓÇ▓ 64
  require cd <= 18446744073709551615
  require cd <ΓÇ▓ calldata.size
  if ('cd', 4).length > 18446744073709551615:
      revert with 0, 65
  if (32 * ('cd', 4).length) + 128 < 96 or (32 * ('cd', 4).length) + 128 > 18446744073709551615:
      revert with 0, 65
  mem[64] = (32 * ('cd', 4).length) + 128
  mem[96] = ('cd', 4).length
  require calldata.size >= cd * ('cd', 4).length) + 36
  s = cd[4] + 36
  t = 128
  idx = 0
  while idx < ('cd', 4).length:
      mem[t] = cd[s]
      s = s + 32
      t = t + 32
      idx = idx + 1
      continue 
  idx = 0
  while idx < ('cd', 4).length:
      if idx >= mem[96]:
          revert with 0, 50
      _32 = mem[(32 * idx) + 128]
      _33 = mem[64]
      mem[mem[64] + 32] = addr(this.address)
      mem[mem[64] + 52] = caller
      mem[mem[64] + 72] = 'execute_proxy' << 152
      mem[mem[64] + 85] = _32
      _34 = mem[64]
      mem[mem[64]] = 85
      mem[64] = mem[64] + 117
      _36 = sha3(mem[_34 + 32 len mem[_34]])
      mem[_33 + 173] = this.address
      mem[_33 + 153] = 0x5af43d82803e903d91602b57fd5bf3ff
      mem[_33 + 137] = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e
      mem[_33 + 117] = 0x3d602d80600a3d3981f3363d3d373d3d3d363d73
      mem[_33 + 205] = _36
      mem[_33 + 237] = sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0)
      if idx >= mem[96]:
          revert with 0, 50
      _41 = mem[(32 * idx) + 128]
      mem[_33 + 117] = 0xf3efc26000000000000000000000000000000000000000000000000000000000
      mem[_33 + 121] = cd[36]
      mem[_33 + 153] = _41
      require ext_code.size(addr(sha3(0, this.address, _36, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))))
      call addr(sha3(0, this.address, _36, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))).0xf3efc260 with:
           gas gas_remaining wei
          args cd_41
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      if idx == -1:
          revert with 0, 17
      idx = idx + 1
      continue 

def unknown98190f47(): # not payable
  require calldata.size - 4 >=ΓÇ▓ 64
  require cd <= 18446744073709551615
  require cd <ΓÇ▓ calldata.size
  if ('cd', 4).length > 18446744073709551615:
      revert with 0, 65
  if (32 * ('cd', 4).length) + 128 < 96 or (32 * ('cd', 4).length) + 128 > 18446744073709551615:
      revert with 0, 65
  mem[64] = (32 * ('cd', 4).length) + 128
  mem[96] = ('cd', 4).length
  require calldata.size >= cd * ('cd', 4).length) + 36
  s = cd[4] + 36
  t = 128
  idx = 0
  while idx < ('cd', 4).length:
      mem[t] = cd[s]
      s = s + 32
      t = t + 32
      idx = idx + 1
      continue 
  require cd == addr(cd)
  idx = 0
  while idx < ('cd', 4).length:
      if idx >= mem[96]:
          revert with 0, 50
      _32 = mem[(32 * idx) + 128]
      _33 = mem[64]
      mem[mem[64] + 32] = addr(this.address)
      mem[mem[64] + 52] = caller
      mem[mem[64] + 72] = 'execute_proxy' << 152
      mem[mem[64] + 85] = _32
      _34 = mem[64]
      mem[mem[64]] = 85
      mem[64] = mem[64] + 117
      _36 = sha3(mem[_34 + 32 len mem[_34]])
      mem[_33 + 173] = this.address
      mem[_33 + 153] = 0x5af43d82803e903d91602b57fd5bf3ff
      mem[_33 + 137] = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e
      mem[_33 + 117] = 0x3d602d80600a3d3981f3363d3d373d3d3d363d73
      mem[_33 + 205] = _36
      mem[_33 + 237] = sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0)
      if idx >= mem[96]:
          revert with 0, 50
      _41 = mem[(32 * idx) + 128]
      mem[_33 + 117] = 0xc027186600000000000000000000000000000000000000000000000000000000
      mem[_33 + 121] = addr(cd)
      mem[_33 + 153] = 100
      mem[_33 + 185] = _41
      require ext_code.size(addr(sha3(0, this.address, _36, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))))
      call addr(sha3(0, this.address, _36, sha3(0x3d602d80600a3d3981f3363d3d373d3d3d363d73, 2002115175177724103, 0))).0xc0271866 with:
           gas gas_remaining wei
          args addr(cd), 100, _41
      if not ext_call.success:
          revert with ext_call.return_data[0 len return_data.size]
      if idx == -1:
          revert with 0, 17
      idx = idx + 1
      continue 
