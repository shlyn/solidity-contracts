// 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e
contract Contract {
    function main() {
        memory[0x40:0x60] = 0x80;
        var var0 = msg.value;
    
        if (var0) { revert(memory[0x00:0x00]); }
    
        if (msg.data.length < 0x04) { revert(memory[0x00:0x00]); }
    
        var0 = msg.data[0x00:0x20] >> 0xe0;
    
        if (0x9a97880c > var0) {
            if (var0 == 0x0c50888c) {
                // Dispatch table entry for 0x0c50888c (unknown)
                var var1 = 0x0095;
                var var2 = 0x0090;
                var var3 = msg.data.length;
                var var4 = 0x04;
                var2, var3 = func_0512(var3, var4);
                var1, var2 = func_0090(var2, var3);
                var temp0 = var1;
                var1 = 0x00a3;
                var temp1 = var2;
                var2 = temp0;
                var3 = temp1;
                var4 = memory[0x40:0x60];
                var1 = func_067F(var2, var3, var4);
            
            label_00A3:
                var temp2 = memory[0x40:0x60];
                return memory[temp2:temp2 + var1 - temp2];
            } else if (var0 == 0x4ed74332) {
                // Dispatch table entry for 0x4ed74332 (unknown)
                var1 = 0x00b4;
                var2 = func_01C8();
            
            label_00B4:
                var temp3 = var2;
                var2 = 0x00a3;
                var3 = temp3;
                var4 = memory[0x40:0x60];
                var2 = func_0652(var3, var4);
                goto label_00A3;
            } else if (var0 == 0x698787c4) {
                // Dispatch table entry for 0x698787c4 (unknown)
                var1 = 0x00d4;
                var2 = 0x00cf;
                var3 = msg.data.length;
                var4 = 0x04;
                var2 = func_05B9(var3, var4);
                func_00CF(var2);
                stop();
            } else { revert(memory[0x00:0x00]); }
        } else if (var0 == 0x9a97880c) {
            // Dispatch table entry for 0x9a97880c (unknown)
            var1 = 0x00b4;
            var2 = 0x00e4;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3, var4 = func_04A5(var3, var4);
            var1 = func_00E4(var2, var3, var4);
            goto label_00B4;
        } else if (var0 == 0xc003598a) {
            // Dispatch table entry for XEN()
            var1 = 0x00b4;
            var2 = XEN();
            goto label_00B4;
        } else if (var0 == 0xc0271866) {
            // Dispatch table entry for 0xc0271866 (unknown)
            var1 = 0x00d4;
            var2 = 0x00ff;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3, var4 = func_04E0(var3, var4);
            func_00FF(var2, var3, var4);
            stop();
        } else if (var0 == 0xf3efc260) {
            // Dispatch table entry for 0xf3efc260 (unknown)
            var1 = 0x00d4;
            var2 = 0x0112;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3 = func_05D1(var3, var4);
            func_0112(var2, var3);
            stop();
        } else { revert(memory[0x00:0x00]); }
    }
    
    function func_0090(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = 0x60;
        var var2 = address(this);
        var var3 = 0x0127;
        var var4 = msg.sender;
        var var5 = tx.origin;
        var var6 = arg1;
        var3 = func_027C(var4, var5, var6);
    
        if (var3 & (0x01 << 0xa0) - 0x01 == var2) {
            var2 = 0x06450dee7fd2fb8e39061434babcfc05599a6fb8;
            var3 = 0x017a;
            var4 = arg0;
            var5 = memory[0x40:0x60];
            var3 = func_0636(var4, var5);
            var temp0 = memory[0x40:0x60];
            var temp1;
            temp1, memory[temp0:temp0 + 0x00] = address(var2).call.gas(msg.gas)(memory[temp0:temp0 + var3 - temp0]);
            var3 = returndata.length;
            var4 = var3;
        
            if (var4 == 0x00) {
                arg0 = 0x60;
                r0 = var2;
                return r0, arg0;
            } else {
                var temp2 = memory[0x40:0x60];
                var3 = temp2;
                memory[0x40:0x60] = var3 + (returndata.length + 0x3f & ~0x1f);
                memory[var3:var3 + 0x20] = returndata.length;
                var temp3 = returndata.length;
                memory[var3 + 0x20:var3 + 0x20 + temp3] = returndata[0x00:0x00 + temp3];
                arg0 = var3;
                r0 = var2;
                return r0, arg0;
            }
        } else {
            var temp4 = memory[0x40:0x60];
            memory[temp4:temp4 + 0x20] = 0x461bcd << 0xe5;
            var3 = temp4 + 0x04;
            var2 = 0x014d;
            var2 = func_06BB(var3);
            var temp5 = memory[0x40:0x60];
            revert(memory[temp5:temp5 + var2 - temp5]);
        }
    }
    
    function func_00CF(var arg0) {
        var var0 = address(this);
        var var1 = 0x01ec;
        var var2 = msg.sender;
        var var3 = tx.origin;
        var var4 = arg0;
        var1 = func_027C(var2, var3, var4);
    
        if (var1 & (0x01 << 0xa0) - 0x01 == var0) {
            var0 = (0x01 << 0xa0) - 0x01 & 0x06450dee7fd2fb8e39061434babcfc05599a6fb8;
            var1 = 0x52c7f8dc;
            var temp0 = memory[0x40:0x60];
            memory[temp0:temp0 + 0x20] = (var1 & 0xffffffff) << 0xe0;
            var2 = temp0 + 0x04;
            var3 = 0x00;
            var4 = memory[0x40:0x60];
            var var5 = var2 - var4;
            var var6 = var4;
            var var7 = 0x00;
            var var8 = var0;
            var var9 = !address(var8).code.length;
        
            if (var9) { revert(memory[0x00:0x00]); }
        
            var temp1;
            temp1, memory[var4:var4 + var3] = address(var8).call.gas(msg.gas).value(var7)(memory[var6:var6 + var5]);
            var3 = !temp1;
        
            if (!var3) { return; }
        
            var temp2 = returndata.length;
            memory[0x00:0x00 + temp2] = returndata[0x00:0x00 + temp2];
            revert(memory[0x00:0x00 + returndata.length]);
        } else {
            var temp3 = memory[0x40:0x60];
            memory[temp3:temp3 + 0x20] = 0x461bcd << 0xe5;
            var1 = temp3 + 0x04;
            var0 = 0x014d;
            var0 = func_06BB(var1);
            var temp4 = memory[0x40:0x60];
            revert(memory[temp4:temp4 + var0 - temp4]);
        }
    }
    
    function func_00E4(var arg0, var arg1, var arg2) returns (var r0) {
        r0 = func_027C(arg0, arg1, arg2);
        // Error: Could not resolve method call return address!
    }
    
    function func_00FF(var arg0, var arg1, var arg2) {
        var var0 = address(this);
        var var1 = 0x02f8;
        var var2 = msg.sender;
        var var3 = tx.origin;
        var var4 = arg2;
        var1 = func_027C(var2, var3, var4);
    
        if (var1 & (0x01 << 0xa0) - 0x01 == var0) {
            var temp0 = memory[0x40:0x60];
            memory[temp0:temp0 + 0x20] = 0x1c560305 << 0xe0;
            var0 = 0x06450dee7fd2fb8e39061434babcfc05599a6fb8;
            var1 = 0x1c560305;
            var2 = 0x0357;
            var3 = arg0;
            var4 = arg1;
            var var5 = temp0 + 0x04;
            var2 = func_0666(var3, var4, var5);
            var3 = 0x00;
            var4 = memory[0x40:0x60];
            var5 = var2 - var4;
            var var6 = var4;
            var var7 = 0x00;
            var var8 = var0;
            var var9 = !address(var8).code.length;
        
            if (var9) { revert(memory[0x00:0x00]); }
        
            var temp1;
            temp1, memory[var4:var4 + var3] = address(var8).call.gas(msg.gas).value(var7)(memory[var6:var6 + var5]);
            var3 = !temp1;
        
            if (!var3) { return; }
        
            var temp2 = returndata.length;
            memory[0x00:0x00 + temp2] = returndata[0x00:0x00 + temp2];
            revert(memory[0x00:0x00 + returndata.length]);
        } else {
            var temp3 = memory[0x40:0x60];
            memory[temp3:temp3 + 0x20] = 0x461bcd << 0xe5;
            var1 = temp3 + 0x04;
            var0 = 0x014d;
            var0 = func_06BB(var1);
            var temp4 = memory[0x40:0x60];
            revert(memory[temp4:temp4 + var0 - temp4]);
        }
    }
    
    function func_0112(var arg0, var arg1) {
        var var0 = address(this);
        var var1 = 0x039a;
        var var2 = msg.sender;
        var var3 = tx.origin;
        var var4 = arg1;
        var1 = func_027C(var2, var3, var4);
    
        if (var1 & (0x01 << 0xa0) - 0x01 == var0) {
            var temp0 = memory[0x40:0x60];
            memory[temp0:temp0 + 0x20] = 0x9ff054df << 0xe0;
            var0 = 0x06450dee7fd2fb8e39061434babcfc05599a6fb8;
            var1 = 0x9ff054df;
            var2 = 0x03f7;
            var3 = arg0;
            var4 = temp0 + 0x04;
            var2 = func_06FE(var3, var4);
            var3 = 0x00;
            var4 = memory[0x40:0x60];
            var var5 = var2 - var4;
            var var6 = var4;
            var var7 = 0x00;
            var var8 = var0;
            var var9 = !address(var8).code.length;
        
            if (var9) { revert(memory[0x00:0x00]); }
        
            var temp1;
            temp1, memory[var4:var4 + var3] = address(var8).call.gas(msg.gas).value(var7)(memory[var6:var6 + var5]);
            var3 = !temp1;
        
            if (!var3) { return; }
        
            var temp2 = returndata.length;
            memory[0x00:0x00 + temp2] = returndata[0x00:0x00 + temp2];
            revert(memory[0x00:0x00 + returndata.length]);
        } else {
            var temp3 = memory[0x40:0x60];
            memory[temp3:temp3 + 0x20] = 0x461bcd << 0xe5;
            var1 = temp3 + 0x04;
            var0 = 0x014d;
            var0 = func_06BB(var1);
            var temp4 = memory[0x40:0x60];
            revert(memory[temp4:temp4 + var0 - temp4]);
        }
    }
    
    function func_01C8() returns (var r0) { return 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e; }
    
    function func_027C(var arg0, var arg1, var arg2) returns (var r0) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x0294;
        var var3 = arg0;
        var var4 = arg1;
        var var6 = memory[0x40:0x60] + 0x20;
        var var5 = arg2;
        var2 = func_05F2(var3, var4, var5, var6);
        var temp0 = memory[0x40:0x60];
        var temp1 = var2;
        memory[temp0:temp0 + 0x20] = temp1 - temp0 - 0x20;
        memory[0x40:0x60] = temp1;
        var1 = keccak256(memory[temp0 + 0x20:temp0 + 0x20 + memory[temp0:temp0 + 0x20]]);
        var2 = 0x02cb;
        var3 = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e;
        var4 = var1;
        var5 = arg0;
        return func_042D(var3, var4, var5);
    }
    
    function XEN() returns (var r0) { return 0x06450dee7fd2fb8e39061434babcfc05599a6fb8; }
    
    function func_042D(var arg0, var arg1, var arg2) returns (var r0) {
        var temp0 = memory[0x40:0x60];
        memory[temp0 + 0x38:temp0 + 0x38 + 0x20] = arg2;
        memory[temp0 + 0x24:temp0 + 0x24 + 0x20] = 0x5af43d82803e903d91602b57fd5bf3ff;
        memory[temp0 + 0x14:temp0 + 0x14 + 0x20] = arg0;
        memory[temp0:temp0 + 0x20] = 0x3d602d80600a3d3981f3363d3d373d3d3d363d73;
        memory[temp0 + 0x58:temp0 + 0x58 + 0x20] = arg1;
        memory[temp0 + 0x78:temp0 + 0x78 + 0x20] = keccak256(memory[temp0 + 0x0c:temp0 + 0x0c + 0x37]);
        return keccak256(memory[temp0 + 0x43:temp0 + 0x43 + 0x55]);
    }
    
    function func_0489(var arg0) returns (var r0) {
        var temp0 = msg.data[arg0:arg0 + 0x20];
        var var0 = temp0;
    
        if (var0 == var0 & (0x01 << 0xa0) - 0x01) { return var0; }
        else { revert(memory[0x00:0x00]); }
    }
    
    function func_04A5(var arg0, var arg1) returns (var r0, var arg0, var arg1) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x00;
    
        if (arg0 - arg1 i>= 0x60) {
            var var3 = 0x04c2;
            var var4 = arg1;
            var3 = func_0489(var4);
            var0 = var3;
            var3 = 0x04d0;
            var4 = arg1 + 0x20;
            var3 = func_0489(var4);
            arg1 = msg.data[arg1 + 0x40:arg1 + 0x40 + 0x20];
            arg0 = var3;
            r0 = var0;
            return r0, arg0, arg1;
        } else {
            var temp0 = var0;
            revert(memory[temp0:temp0 + temp0]);
        }
    }
    
    function func_04E0(var arg0, var arg1) returns (var r0, var arg0, var arg1) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x00;
    
        if (arg0 - arg1 i>= 0x60) {
            var var3 = 0x04fd;
            var var4 = arg1;
            var3 = func_0489(var4);
            r0 = var3;
            var temp0 = arg1;
            arg0 = msg.data[temp0 + 0x20:temp0 + 0x20 + 0x20];
            arg1 = msg.data[temp0 + 0x40:temp0 + 0x40 + 0x20];
            return r0, arg0, arg1;
        } else {
            var temp1 = var0;
            revert(memory[temp1:temp1 + temp1]);
        }
    }
    
    function func_0512(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = var0;
    
        if (arg0 - arg1 i>= 0x40) {
            var var2 = msg.data[arg1:arg1 + 0x20];
            var var3 = 0xffffffffffffffff;
        
            if (var2 <= var3) {
                var temp0 = arg1 + var2;
                var2 = temp0;
            
                if (var2 + 0x1f i< arg0) {
                    var var4 = msg.data[var2:var2 + 0x20];
                    var var5 = 0x20;
                
                    if (var4 <= var3) {
                        var temp1 = memory[0x40:0x60];
                        var var6 = temp1;
                        var temp2 = var5 + var6 + (var4 + 0x1f & ~0x1f);
                        var var7 = temp2;
                    
                        if (!((var7 < var6) | (var7 > var3))) {
                            memory[0x40:0x60] = var7;
                            var temp3 = var4;
                            memory[var6:var6 + 0x20] = temp3;
                        
                            if (arg0 >= var5 + temp3 + var2) {
                                var temp4 = var4;
                                var temp5 = var5;
                                var temp6 = var6;
                                memory[temp6 + temp5:temp6 + temp5 + temp4] = msg.data[var2 + temp5:var2 + temp5 + temp4];
                                memory[temp5 + temp6 + temp4:temp5 + temp6 + temp4 + 0x20] = var0;
                                r0 = temp6;
                                arg0 = msg.data[temp5 + arg1:temp5 + arg1 + 0x20];
                                return r0, arg0;
                            } else {
                                var temp7 = var0;
                                revert(memory[temp7:temp7 + temp7]);
                            }
                        } else {
                            var var8 = 0x0585;
                        
                        label_0737:
                            memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                            memory[0x04:0x24] = 0x41;
                            revert(memory[0x00:0x24]);
                        }
                    } else {
                        var6 = 0x0562;
                        goto label_0737;
                    }
                } else {
                    var temp8 = var0;
                    revert(memory[temp8:temp8 + temp8]);
                }
            } else {
                var temp9 = var0;
                revert(memory[temp9:temp9 + temp9]);
            }
        } else {
            var temp10 = var0;
            revert(memory[temp10:temp10 + temp10]);
        }
    }
    
    function func_05B9(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
    
        if (arg0 - arg1 i>= 0x20) { return msg.data[arg1:arg1 + 0x20]; }
    
        var temp0 = var0;
        revert(memory[temp0:temp0 + temp0]);
    }
    
    function func_05D1(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = var0;
    
        if (arg0 - arg1 i>= 0x40) {
            var temp0 = arg1;
            r0 = msg.data[temp0:temp0 + 0x20];
            arg0 = msg.data[temp0 + 0x20:temp0 + 0x20 + 0x20];
            return r0, arg0;
        } else {
            var temp1 = var0;
            revert(memory[temp1:temp1 + temp1]);
        }
    }
    
    function func_05F2(var arg0, var arg1, var arg2, var arg3) returns (var r0) {
        var temp0 = ~0xffffffffffffffffffffffff;
        var temp1 = arg3;
        memory[temp1:temp1 + 0x20] = temp0 & (arg0 << 0x60);
        memory[temp1 + 0x14:temp1 + 0x14 + 0x20] = temp0 & (arg1 << 0x60);
        memory[temp1 + 0x28:temp1 + 0x28 + 0x20] = 0x657865637574655f70726f7879 << 0x98;
        memory[temp1 + 0x35:temp1 + 0x35 + 0x20] = arg2;
        return temp1 + 0x55;
    }
    
    function func_0636(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
        var temp0 = arg0;
        var var1 = memory[temp0:temp0 + 0x20];
        var var2 = 0x0648;
        var var3 = var1;
        var var4 = arg1;
        var var5 = temp0 + 0x20;
        func_0707(var3, var4, var5);
        return var1 + arg1;
    }
    
    function func_0652(var arg0, var arg1) returns (var r0) {
        var temp0 = arg1;
        memory[temp0:temp0 + 0x20] = arg0 & (0x01 << 0xa0) - 0x01;
        return temp0 + 0x20;
    }
    
    function func_0666(var arg0, var arg1, var arg2) returns (var r0) {
        var temp0 = arg2;
        memory[temp0:temp0 + 0x20] = arg0 & (0x01 << 0xa0) - 0x01;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = arg1;
        return temp0 + 0x40;
    }
    
    function func_067F(var arg0, var arg1, var arg2) returns (var r0) {
        var var0 = 0x00;
        var temp0 = arg2;
        memory[temp0:temp0 + 0x20] = !!arg0;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = 0x40;
        var temp1 = arg1;
        var temp2 = memory[temp1:temp1 + 0x20];
        var var1 = temp2;
        memory[temp0 + 0x40:temp0 + 0x40 + 0x20] = var1;
        var var2 = 0x06a6;
        var var3 = var1;
        var var4 = temp0 + 0x60;
        var var5 = temp1 + 0x20;
        func_0707(var3, var4, var5);
        return (var1 + 0x1f & ~0x1f) + arg2 + 0x60;
    }
    
    function func_06BB(var arg0) returns (var r0) {
        var temp0 = arg0;
        memory[temp0:temp0 + 0x20] = 0x20;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = 0x23;
        memory[temp0 + 0x40:temp0 + 0x40 + 0x20] = 0x43616c6c6572206d7573742062652058656e20426174636820436f6e74726f6c;
        memory[temp0 + 0x60:temp0 + 0x60 + 0x20] = 0x3632b9 << 0xe9;
        return temp0 + 0x80;
    }
    
    function func_06FE(var arg0, var arg1) returns (var r0) {
        var temp0 = arg1;
        memory[temp0:temp0 + 0x20] = arg0;
        return temp0 + 0x20;
    }
    
    function func_0707(var arg0, var arg1, var arg2) {
        var var0 = 0x00;
    
        if (var0 >= arg0) {
        label_0722:
        
            if (var0 <= arg0) { return; }
        
            memory[arg1 + arg0:arg1 + arg0 + 0x20] = 0x00;
            return;
        } else {
        label_0713:
            var temp0 = var0;
            memory[temp0 + arg1:temp0 + arg1 + 0x20] = memory[temp0 + arg2:temp0 + arg2 + 0x20];
            var0 = temp0 + 0x20;
        
            if (var0 >= arg0) { goto label_0722; }
            else { goto label_0713; }
        }
    }
}


