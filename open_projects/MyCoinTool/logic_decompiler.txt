contract Contract {
    function main() {
        memory[0x40:0x60] = 0x80;
    
        if (msg.data.length < 0x04) { revert(memory[0x00:0x00]); }
    
        var var0 = msg.data[0x00:0x20] >> 0xe0;
    
        if (0xb7595c3b > var0) {
            if (var0 == 0x0a473c2b) {
                // Dispatch table entry for 0x0a473c2b (unknown)
                var var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00b6;
                var var2 = 0x00b1;
                var var3 = msg.data.length;
                var var4 = 0x04;
                var2 = func_08A6(var3, var4);
                var2 = func_00B1(var2);
                var temp0 = var2;
                var2 = 0x00c3;
                var3 = temp0;
                var4 = memory[0x40:0x60];
                var2 = func_0CF0(var3, var4);
            
            label_00C3:
                var temp1 = memory[0x40:0x60];
                return memory[temp1:temp1 + var2 - temp1];
            } else if (var0 == 0x18a74fc0) {
                // Dispatch table entry for 0x18a74fc0 (unknown)
                var1 = 0x00df;
                var2 = 0x00da;
                var3 = msg.data.length;
                var4 = 0x04;
                var2, var3 = func_0977(var3, var4);
                func_00DA(var2, var3);
                stop();
            } else if (var0 == 0x4ed74332) {
                // Dispatch table entry for 0x4ed74332 (unknown)
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00f6;
                var2 = func_02BF();
            
            label_00F6:
                var temp2 = var2;
                var2 = 0x00c3;
                var3 = temp2;
                var4 = memory[0x40:0x60];
                var2 = func_0C84(var3, var4);
                goto label_00C3;
            } else if (var0 == 0x98190f47) {
                // Dispatch table entry for 0x98190f47 (unknown)
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00df;
                var2 = 0x011e;
                var3 = msg.data.length;
                var4 = 0x04;
                var2, var3 = func_092B(var3, var4);
                func_011E(var2, var3);
                stop();
            } else if (var0 == 0x9a97880c) {
                // Dispatch table entry for 0x9a97880c (unknown)
                var1 = msg.value;
            
                if (var1) { revert(memory[0x00:0x00]); }
            
                var1 = 0x00f6;
                var2 = 0x013e;
                var3 = msg.data.length;
                var4 = 0x04;
                var2, var3, var4 = func_08C7(var3, var4);
                var1 = func_013E(var2, var3, var4);
                goto label_00F6;
            } else { revert(memory[0x00:0x00]); }
        } else if (var0 == 0xb7595c3b) {
            // Dispatch table entry for 0xb7595c3b (unknown)
            var1 = msg.value;
        
            if (var1) { revert(memory[0x00:0x00]); }
        
            var1 = 0x00f6;
            var2 = 0x015e;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3 = func_09BA(var3, var4);
            var1 = func_015E(var2, var3);
            goto label_00F6;
        } else if (var0 == 0xbb739814) {
            // Dispatch table entry for 0xbb739814 (unknown)
            var1 = 0x00df;
            var2 = 0x0171;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3 = func_0A4E(var3, var4);
            func_0171(var2, var3);
            stop();
        } else if (var0 == 0xc003598a) {
            // Dispatch table entry for XEN()
            var1 = msg.value;
        
            if (var1) { revert(memory[0x00:0x00]); }
        
            var1 = 0x00f6;
            var2 = XEN();
            goto label_00F6;
        } else if (var0 == 0xc8785396) {
            // Dispatch table entry for 0xc8785396 (unknown)
            var1 = msg.value;
        
            if (var1) { revert(memory[0x00:0x00]); }
        
            var1 = 0x00df;
            var2 = 0x01a6;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3, var4 = func_0A6F(var3, var4);
            func_01A6(var2, var3, var4);
            stop();
        } else if (var0 == 0xfbf551ad) {
            // Dispatch table entry for 0xfbf551ad (unknown)
            var1 = msg.value;
        
            if (var1) { revert(memory[0x00:0x00]); }
        
            var1 = 0x00f6;
            var2 = 0x01c6;
            var3 = msg.data.length;
            var4 = 0x04;
            var2, var3 = func_0902(var3, var4);
            var1 = func_01C6(var2, var3);
            goto label_00F6;
        } else { revert(memory[0x00:0x00]); }
    }
    
    function func_00B1(var arg0) returns (var arg0) {
        memory[0x20:0x40] = 0x00;
        memory[0x00:0x20] = arg0;
        return storage[keccak256(memory[0x00:0x40])];
    }
    
    function func_00DA(var arg0, var arg1) {
        var var0 = 0x00;
    
        if (var0 >= memory[arg0:arg0 + 0x20]) {
        label_02BA:
            return;
        } else {
        label_01EA:
            var var1 = 0x00;
            var var2 = 0x021d;
            var var3 = address(this);
            var var4 = msg.sender;
            var var5 = arg0;
            var var6 = var0;
        
            if (var6 < memory[var5:var5 + 0x20]) {
                var2 = func_0210(var3, var4, var5, var6);
                var1 = var2;
                var2 = var1 & (0x01 << 0xa0) - 0x01;
                var3 = 0xf3efc260;
                var4 = arg1;
                var5 = arg0;
                var6 = var0;
            
                if (var6 < memory[var5:var5 + 0x20]) {
                    var temp0 = memory[var6 * 0x20 + 0x20 + var5:var6 * 0x20 + 0x20 + var5 + 0x20];
                    var temp1 = memory[0x40:0x60];
                    memory[temp1:temp1 + 0x20] = (var3 & 0xffffffff) << 0xe0;
                    var temp2 = var4;
                    var4 = 0x0274;
                    var5 = temp2;
                    var6 = temp0;
                    var var7 = temp1 + 0x04;
                    var4 = func_0CF9(var5, var6, var7);
                    var5 = 0x00;
                    var6 = memory[0x40:0x60];
                    var7 = var4 - var6;
                    var var8 = var6;
                    var var9 = 0x00;
                    var var10 = var2;
                    var var11 = !address(var10).code.length;
                
                    if (var11) { revert(memory[0x00:0x00]); }
                
                    var temp3;
                    temp3, memory[var6:var6 + var5] = address(var10).call.gas(msg.gas).value(var9)(memory[var8:var8 + var7]);
                    var5 = !temp3;
                
                    if (!var5) {
                        var1 = var0;
                        var2 = 0x02b2;
                        var3 = var1;
                        var2 = func_0D49(var3);
                        var0 = var2;
                    
                        if (var0 >= memory[arg0:arg0 + 0x20]) { goto label_02BA; }
                        else { goto label_01EA; }
                    } else {
                        var temp4 = returndata.length;
                        memory[0x00:0x00 + temp4] = returndata[0x00:0x00 + temp4];
                        revert(memory[0x00:0x00 + returndata.length]);
                    }
                } else {
                    memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                    memory[0x04:0x24] = 0x32;
                    revert(memory[0x00:0x24]);
                }
            } else {
                memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                memory[0x04:0x24] = 0x32;
                revert(memory[0x00:0x24]);
            }
        }
    }
    
    function func_011E(var arg0, var arg1) {
        var var0 = 0x00;
    
        if (var0 >= memory[arg0:arg0 + 0x20]) {
        label_02BA:
            return;
        } else {
        label_02E4:
            var var1 = 0x00;
            var var2 = 0x030a;
            var var3 = address(this);
            var var4 = msg.sender;
            var var5 = arg0;
            var var6 = var0;
        
            if (var6 < memory[var5:var5 + 0x20]) {
                var2 = func_0210(var3, var4, var5, var6);
                var1 = var2;
                var2 = var1 & (0x01 << 0xa0) - 0x01;
                var3 = 0xc0271866;
                var4 = arg1;
                var5 = 0x64;
                var6 = arg0;
                var var7 = var0;
            
                if (var7 < memory[var6:var6 + 0x20]) {
                    var temp0 = memory[var7 * 0x20 + 0x20 + var6:var7 * 0x20 + 0x20 + var6 + 0x20];
                    var temp1 = memory[0x40:0x60];
                    memory[temp1:temp1 + 0x20] = (var3 & 0xffffffff) << 0xe0;
                    var temp2 = var4;
                    var4 = 0x0364;
                    var temp3 = var5;
                    var5 = temp2;
                    var6 = temp3;
                    var7 = temp0;
                    var var8 = temp1 + 0x04;
                    var4 = func_0C98(var5, var6, var7, var8);
                    var5 = 0x00;
                    var6 = memory[0x40:0x60];
                    var7 = var4 - var6;
                    var8 = var6;
                    var var9 = 0x00;
                    var var10 = var2;
                    var var11 = !address(var10).code.length;
                
                    if (var11) { revert(memory[0x00:0x00]); }
                
                    var temp4;
                    temp4, memory[var6:var6 + var5] = address(var10).call.gas(msg.gas).value(var9)(memory[var8:var8 + var7]);
                    var5 = !temp4;
                
                    if (!var5) {
                        var1 = var0;
                        var2 = 0x03a2;
                        var3 = var1;
                        var2 = func_0D49(var3);
                        var0 = var2;
                    
                        if (var0 >= memory[arg0:arg0 + 0x20]) { goto label_02BA; }
                        else { goto label_02E4; }
                    } else {
                        var temp5 = returndata.length;
                        memory[0x00:0x00 + temp5] = returndata[0x00:0x00 + temp5];
                        revert(memory[0x00:0x00 + returndata.length]);
                    }
                } else {
                    memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                    memory[0x04:0x24] = 0x32;
                    revert(memory[0x00:0x24]);
                }
            } else {
                memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                memory[0x04:0x24] = 0x32;
                revert(memory[0x00:0x24]);
            }
        }
    }
    
    function func_013E(var arg0, var arg1, var arg2) returns (var r0) {
        r0 = func_03AA(arg0, arg1, arg2);
        // Error: Could not resolve method call return address!
    }
    
    function func_015E(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
        var temp0 = arg0;
        var temp1 = new(memory[temp0 + 0x20:temp0 + 0x20 + memory[temp0:temp0 + 0x20]]).value(0x00).salt(arg1)();
        var var1 = temp1;
    
        if (address(var1).code.length) { return var1; }
        else { revert(memory[0x00:0x00]); }
    }

    // times,term 
    function func_0171(var arg0, var arg1) {
        memory[0x00:0x20] = msg.sender;
        memory[0x20:0x40] = 0x00;
        var var0 = storage[keccak256(memory[0x00:0x40])];
        var var1 = var0; // map(msg.sender)

        var var2 = 0x0441; // 1089

        var var3 = arg0;

        var var4 = var1;
        var2 = func_0D31(var3, var4);
    
        if (var1 >= var2) {
            memory[0x00:0x20] = msg.sender;
            memory[0x20:0x40] = 0x00;
            var2 = keccak256(memory[0x00:0x40]);
            var1 = arg0;
            var3 = 0x00;
            var4 = 0x04ea;
            var var5 = var1;
            var var6 = storage[var2];
            var4 = func_0D31(var5, var6);
            storage[var2] = var4;
            return;
        } else {
            var2 = 0x00;
            var3 = 0x0453;
            var4 = var1;
            var5 = 0x00;
            var6 = var5;
            var var7 = 0x0755;

            var var8 = address(this);
            var var9 = msg.sender;
            var var10 = var4;
            var var11 = memory[0x40:0x60] + 0x20;
            var7 = func_0AA3(var8, var9, var10, var11);

            var temp0 = memory[0x40:0x60];
            var temp1 = var7; // memory[0x40:0x60] + 0x20 + 0x55
            // memory[0x40:0x60] + 0x20 + 0x55 - memory[0x40:0x60] - 0x20
            memory[temp0:temp0 + 0x20] = temp1 - temp0 - 0x20; // 0x55
            memory[0x40:0x60] = temp1;
            var6 = keccak256(memory[temp0 + 0x20:temp0 + 0x20 + memory[temp0:temp0 + 0x20]]);
            var7 = 0x00;
            var8 = 0x078d;
            var9 = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e;
            var10 = var6;
            var8 = func_0797(var9, var10);
            var5 = var8;
            var3 = var5;
            // Error: Could not resolve jump destination!
        }
    }
    
    function func_01A6(var arg0, var arg1, var arg2) {
        var var0 = arg0;
    
        if (var0 >= arg1) {
        label_059D:
            return;
        } else {
        label_0517:
            var var1 = 0x00;
            var var2 = 0x0523;
            var var3 = address(this);
            var var4 = msg.sender;
            var var5 = var0;
            var2 = func_03AA(var3, var4, var5);
            var temp0 = memory[0x40:0x60];
            memory[temp0:temp0 + 0x20] = 0x60138c33 << 0xe1;
            var1 = var2;
            var2 = var1 & (0x01 << 0xa0) - 0x01;
            var3 = 0xc0271866;
            var4 = 0x0557;
            var5 = arg2;
            var var6 = 0x64;
            var var7 = var0;
            var var8 = temp0 + 0x04;
            var4 = func_0C98(var5, var6, var7, var8);
            var5 = 0x00;
            var6 = memory[0x40:0x60];
            var7 = var4 - var6;
            var8 = var6;
            var var9 = 0x00;
            var var10 = var2;
            var var11 = !address(var10).code.length;
        
            if (var11) { revert(memory[0x00:0x00]); }
        
            var temp1;
            temp1, memory[var6:var6 + var5] = address(var10).call.gas(msg.gas).value(var9)(memory[var8:var8 + var7]);
            var5 = !temp1;
        
            if (!var5) {
                var1 = var0;
                var2 = 0x0595;
                var3 = var1;
                var2 = func_0D49(var3);
                var0 = var2;
            
                if (var0 >= arg1) { goto label_059D; }
                else { goto label_0517; }
            } else {
                var temp2 = returndata.length;
                memory[0x00:0x00 + temp2] = returndata[0x00:0x00 + temp2];
                revert(memory[0x00:0x00 + returndata.length]);
            }
        }
    }
    
    function func_01C6(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
        var var1 = 0x60;
    
        if (!arg1) {
            var2 = 0x05cf;
            var3 = 0x6b << 0xf9;
            var4 = 0x25 << 0xfa;
            var5 = arg0;
            var6 = 0x01 << 0xff;
            var7 = memory[0x40:0x60] + 0x20;
            var2 = func_0AE2(var3, var4, var5, var6, var7);
            goto label_05CF;
        } else if (arg1 <= 0x7f) {
            var2 = 0x05cf;
            var3 = 0x6b << 0xf9;
            var4 = 0x25 << 0xfa;
            var5 = arg0;
            var6 = arg1;
            var7 = memory[0x40:0x60] + 0x20;
            var2 = func_0C48(var3, var4, var5, var6, var7);
            goto label_05CF;
        } else if (arg1 <= 0xff) {
            var2 = 0x05cf;
            var3 = 0xd7 << 0xf8;
            var4 = 0x25 << 0xfa;
            var5 = arg0;
            var6 = 0x81 << 0xf8;
            var7 = arg1;
            var8 = memory[0x40:0x60] + 0x20;
            var2 = func_0C05(var3, var4, var5, var6, var7, var8);
            goto label_05CF;
        } else if (arg1 <= 0xffff) {
            var2 = 0x05cf;
            var3 = 0x1b << 0xfb;
            var4 = 0x25 << 0xfa;
            var5 = arg0;
            var6 = 0x41 << 0xf9;
            var7 = arg1;
            var8 = memory[0x40:0x60] + 0x20;
            var2 = func_0B1B(var3, var4, var5, var6, var7, var8);
            goto label_05CF;
        } else if (arg1 > 0xffffff) {
            var var2 = 0x06bb;
            var var3 = 0x6d << 0xf9;
            var var4 = 0x25 << 0xfa;
            var var5 = arg0;
            var var6 = 0x21 << 0xfa;
            var var7 = arg1;
            var var8 = memory[0x40:0x60] + 0x20;
            var2 = func_0BB7(var3, var4, var5, var6, var7, var8);
            var temp0 = memory[0x40:0x60];
            var temp1 = var2;
            memory[temp0:temp0 + 0x20] = temp1 - temp0 - 0x20;
            memory[0x40:0x60] = temp1;
            var temp2 = keccak256(memory[temp0 + 0x20:temp0 + 0x20 + memory[temp0:temp0 + 0x20]]);
            memory[0x00:0x20] = temp2;
            return temp2;
        } else {
            var2 = 0x05cf;
            var3 = 0xd9 << 0xf8;
            var4 = 0x25 << 0xfa;
            var5 = arg0;
            var6 = 0x83 << 0xf8;
            var7 = arg1;
            var8 = memory[0x40:0x60] + 0x20;
            var2 = func_0B69(var3, var4, var5, var6, var7, var8);
        
        label_05CF:
            var temp3 = memory[0x40:0x60];
            var temp4 = var2;
            memory[temp3:temp3 + 0x20] = temp4 - temp3 - 0x20;
            memory[0x40:0x60] = temp4;
            var1 = temp3;
            var temp5 = var1;
            var temp6 = keccak256(memory[temp5 + 0x20:temp5 + 0x20 + memory[temp5:temp5 + 0x20]]);
            memory[0x00:0x20] = temp6;
            return temp6;
        }
    }
    
    function func_0210(var arg0, var arg1, var arg2, var arg3) returns (var r0) {
        arg2 = memory[arg3 * 0x20 + 0x20 + arg2:arg3 * 0x20 + 0x20 + arg2 + 0x20];
        r0 = func_03AA(arg0, arg1, arg2);
        // Error: Could not resolve method call return address!
    }
    
    function func_02BF() returns (var r0) { return 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e; }
    
    function func_03AA(var arg0, var arg1, var arg2) returns (var r0) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x03c2;
        var var3 = arg0;
        var var4 = arg1;
        var var5 = arg2;
        var var6 = memory[0x40:0x60] + 0x20;
        var2 = func_0AA3(var3, var4, var5, var6);
        var temp0 = memory[0x40:0x60];
        var temp1 = var2;
        memory[temp0:temp0 + 0x20] = temp1 - temp0 - 0x20;
        memory[0x40:0x60] = temp1;
        var1 = keccak256(memory[temp0 + 0x20:temp0 + 0x20 + memory[temp0:temp0 + 0x20]]);
        var2 = 0x03f9;
        var3 = 0x1bc8f124e7e320c71a6394de0458e8d7ea27623e;
        var4 = var1;
        var5 = arg0;
        return func_06E1(var3, var4, var5);
    }
    
    function XEN() returns (var r0) { return 0x06450dee7fd2fb8e39061434babcfc05599a6fb8; }
    
    function func_06E1(var arg0, var arg1, var arg2) returns (var r0) {
        var temp0 = memory[0x40:0x60];
        memory[temp0 + 0x38:temp0 + 0x38 + 0x20] = arg2;
        memory[temp0 + 0x24:temp0 + 0x24 + 0x20] = 0x5af43d82803e903d91602b57fd5bf3ff;
        memory[temp0 + 0x14:temp0 + 0x14 + 0x20] = arg0;
        memory[temp0:temp0 + 0x20] = 0x3d602d80600a3d3981f3363d3d373d3d3d363d73;
        memory[temp0 + 0x58:temp0 + 0x58 + 0x20] = arg1;
        memory[temp0 + 0x78:temp0 + 0x78 + 0x20] = keccak256(memory[temp0 + 0x0c:temp0 + 0x0c + 0x37]);
        return keccak256(memory[temp0 + 0x43:temp0 + 0x43 + 0x55]);
    }
    
    function func_0797(var arg0, var arg1) returns (var r0) {
        var temp0 = arg0;
        memory[0x00:0x20] = ((temp0 << 0x60) >> 0xe8) | 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000;
        memory[0x20:0x40] = (temp0 << 0x78) | 0x5af43d82803e903d91602b57fd5bf3;
        var temp1 = new(memory[0x09:0x40]).value(0x00).salt(arg1)();
        var var0 = temp1;
    
        if (var0 & (0x01 << 0xa0) - 0x01) { return var0; }
    
        var temp2 = memory[0x40:0x60];
        memory[temp2:temp2 + 0x20] = 0x461bcd << 0xe5;
        var var2 = temp2 + 0x04;
        var var1 = 0x0804;
        var1 = func_0CB9(var2);
        var temp3 = memory[0x40:0x60];
        revert(memory[temp3:temp3 + var1 - temp3]);
    }
    
    function func_080D(var arg0) returns (var r0) {
        var temp0 = msg.data[arg0:arg0 + 0x20];
        var var0 = temp0;
    
        if (var0 == var0 & (0x01 << 0xa0) - 0x01) { return var0; }
        else { revert(memory[0x00:0x00]); }
    }
    
    function func_0824(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
    
        if (arg1 + 0x1f i< arg0) {
            var var1 = msg.data[arg1:arg1 + 0x20];
            var var2 = 0x20;
        
            if (var1 <= 0xffffffffffffffff) {
                var temp0 = var2;
                var var3 = var1 * temp0;
                var var4 = 0x085e;
                var var5 = var3 + temp0;
                var4 = func_0D07(var5);
                var temp1 = var4;
                memory[temp1:temp1 + 0x20] = var1;
                var temp2 = var2;
                var5 = temp1;
                var4 = var5 + temp2;
                var temp3 = arg1;
                var var6 = temp2 + temp3;
            
                if (arg0 >= temp2 + temp3 + var3) {
                    var3 = var0;
                
                    if (var3 >= var1) {
                    label_089A:
                        return var5;
                    } else {
                    label_0885:
                        var temp4 = var6;
                        var temp5 = var4;
                        memory[temp5:temp5 + 0x20] = msg.data[temp4:temp4 + 0x20];
                        var3 = var3 + 0x01;
                        var temp6 = var2;
                        var4 = temp6 + temp5;
                        var6 = temp6 + temp4;
                    
                        if (var3 >= var1) { goto label_089A; }
                        else { goto label_0885; }
                    }
                } else {
                    var temp7 = var0;
                    revert(memory[temp7:temp7 + temp7]);
                }
            } else {
                var3 = 0x0850;
                memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                memory[0x04:0x24] = 0x41;
                revert(memory[0x00:0x24]);
            }
        } else {
            var temp8 = var0;
            revert(memory[temp8:temp8 + temp8]);
        }
    }
    
    function func_08A6(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
    
        if (arg0 - arg1 i>= 0x20) {
            var var1 = 0x08c0;
            var var2 = arg1;
            return func_080D(var2);
        } else {
            var temp0 = var0;
            revert(memory[temp0:temp0 + temp0]);
        }
    }
    
    function func_08C7(var arg0, var arg1) returns (var r0, var arg0, var arg1) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x00;
    
        if (arg0 - arg1 i>= 0x60) {
            var var3 = 0x08e4;
            var var4 = arg1;
            var3 = func_080D(var4);
            var0 = var3;
            var3 = 0x08f2;
            var4 = arg1 + 0x20;
            var3 = func_080D(var4);
            arg1 = msg.data[arg1 + 0x40:arg1 + 0x40 + 0x20];
            arg0 = var3;
            r0 = var0;
            return r0, arg0, arg1;
        } else {
            var temp0 = var1;
            revert(memory[temp0:temp0 + temp0]);
        }
    }
    
    function func_0902(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = var0;
    
        if (arg0 - arg1 i>= 0x40) {
            var var2 = 0x091d;
            var var3 = arg1;
            var2 = func_080D(var3);
            r0 = var2;
            arg0 = msg.data[arg1 + 0x20:arg1 + 0x20 + 0x20];
            return r0, arg0;
        } else {
            var temp0 = var0;
            revert(memory[temp0:temp0 + temp0]);
        }
    }
    
    function func_092B(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = var0;
    
        if (arg0 - arg1 i>= 0x40) {
            var var2 = msg.data[arg1:arg1 + 0x20];
        
            if (var2 <= 0xffffffffffffffff) {
                var var3 = 0x095f;
                var var4 = arg0;
                var var5 = arg1 + var2;
                var3 = func_0824(var4, var5);
                var0 = var3;
                var2 = 0x096e;
                var3 = arg1 + 0x20;
                var2 = func_080D(var3);
                arg0 = var2;
                r0 = var0;
                return r0, arg0;
            } else {
                var temp0 = var0;
                revert(memory[temp0:temp0 + temp0]);
            }
        } else {
            var temp1 = var0;
            revert(memory[temp1:temp1 + temp1]);
        }
    }
    
    function func_0977(var arg0, var arg1) returns (var r0, var arg0) {
        var var0 = 0x00;
        var var1 = var0;
    
        if (arg0 - arg1 i>= 0x40) {
            var var2 = msg.data[arg1:arg1 + 0x20];
        
            if (var2 <= 0xffffffffffffffff) {
                var var3 = 0x09ab;
                var var4 = arg0;
                var var5 = arg1 + var2;
                var3 = func_0824(var4, var5);
                r0 = var3;
                arg0 = msg.data[arg1 + 0x20:arg1 + 0x20 + 0x20];
                return r0, arg0;
            } else {
                var temp0 = var0;
                revert(memory[temp0:temp0 + temp0]);
            }
        } else {
            var temp1 = var0;
            revert(memory[temp1:temp1 + temp1]);
        }
    }
    
    function func_09BA(var arg0, var arg1) returns (var r0, var arg0) {
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
                        var var6 = 0x0a1c;
                        var var7 = var5 + (var4 + 0x1f & ~0x1f);
                        var6 = func_0D07(var7);
                        var3 = var6;
                        var temp1 = var4;
                        memory[var3:var3 + 0x20] = temp1;
                    
                        if (var2 + temp1 + var5 <= arg0) {
                            var temp2 = var4;
                            var temp3 = var5;
                            var temp4 = var3;
                            memory[temp4 + temp3:temp4 + temp3 + temp2] = msg.data[var2 + temp3:var2 + temp3 + temp2];
                            memory[temp3 + temp4 + temp2:temp3 + temp4 + temp2 + 0x20] = var0;
                            r0 = temp4;
                            arg0 = msg.data[temp3 + arg1:temp3 + arg1 + 0x20];
                            return r0, arg0;
                        } else {
                            var temp5 = var0;
                            revert(memory[temp5:temp5 + temp5]);
                        }
                    } else {
                        var6 = 0x0a0a;
                        memory[0x00:0x20] = 0x4e487b71 << 0xe0;
                        memory[0x04:0x24] = 0x41;
                        revert(memory[0x00:0x24]);
                    }
                } else {
                    var temp6 = var0;
                    revert(memory[temp6:temp6 + temp6]);
                }
            } else {
                var temp7 = var0;
                revert(memory[temp7:temp7 + temp7]);
            }
        } else {
            var temp8 = var0;
            revert(memory[temp8:temp8 + temp8]);
        }
    }
    
    function func_0A4E(var arg0, var arg1) returns (var r0, var arg0) {
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
    
    function func_0A6F(var arg0, var arg1) returns (var r0, var arg0, var arg1) {
        var var0 = 0x00;
        var var1 = var0;
        var var2 = 0x00;
    
        if (arg0 - arg1 i>= 0x60) {
            var temp0 = arg1;
            var0 = msg.data[temp0:temp0 + 0x20];
            var1 = msg.data[temp0 + 0x20:temp0 + 0x20 + 0x20];
            var var3 = 0x0a9a;
            var var4 = temp0 + 0x40;
            var3 = func_080D(var4);
            arg1 = var3;
            arg0 = var1;
            r0 = var0;
            return r0, arg0, arg1;
        } else {
            var temp1 = var0;
            revert(memory[temp1:temp1 + temp1]);
        }
    }
    
    function func_0AA3(var arg0, var arg1, var arg2, var arg3) returns (var r0) {
        var temp0 = ~((0x01 << 0x60) - 0x01);
        var temp1 = arg3;
        memory[temp1:temp1 + 0x20] = temp0 & (arg0 << 0x60);
        memory[temp1 + 0x14:temp1 + 0x14 + 0x20] = temp0 & (arg1 << 0x60);
        memory[temp1 + 0x28:temp1 + 0x28 + 0x20] = 0x657865637574655f70726f7879 << 0x98;
        memory[temp1 + 0x35:temp1 + 0x35 + 0x20] = arg2;
        return temp1 + 0x55;
    }
    
    function func_0AE2(var arg0, var arg1, var arg2, var arg3, var arg4) returns (var r0) {
        var temp0 = arg4;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = arg3 & ~((0x01 << 0xf8) - 0x01);
        return temp0 + 0x17;
    }
    
    function func_0B1B(var arg0, var arg1, var arg2, var arg3, var arg4, var arg5) returns (var r0) {
        var temp0 = arg5;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = arg3 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x17:temp0 + 0x17 + 0x20] = (arg4 << 0xf0) & ~((0x01 << 0xf0) - 0x01);
        return temp0 + 0x19;
    }
    
    function func_0B69(var arg0, var arg1, var arg2, var arg3, var arg4, var arg5) returns (var r0) {
        var temp0 = arg5;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = arg3 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x17:temp0 + 0x17 + 0x20] = (arg4 << 0xe8) & ~((0x01 << 0xe8) - 0x01);
        return temp0 + 0x1a;
    }
    
    function func_0BB7(var arg0, var arg1, var arg2, var arg3, var arg4, var arg5) returns (var r0) {
        var temp0 = arg5;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = arg3 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x17:temp0 + 0x17 + 0x20] = (arg4 << 0xe0) & ~((0x01 << 0xe0) - 0x01);
        return temp0 + 0x1b;
    }
    
    function func_0C05(var arg0, var arg1, var arg2, var arg3, var arg4, var arg5) returns (var r0) {
        var temp0 = arg5;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = arg3 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x17:temp0 + 0x17 + 0x20] = (arg4 << 0xf8) & ~((0x01 << 0xf8) - 0x01);
        return temp0 + 0x18;
    }
    
    function func_0C48(var arg0, var arg1, var arg2, var arg3, var arg4) returns (var r0) {
        var temp0 = arg4;
        memory[temp0:temp0 + 0x20] = arg0 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x01:temp0 + 0x01 + 0x20] = arg1 & ~((0x01 << 0xf8) - 0x01);
        memory[temp0 + 0x02:temp0 + 0x02 + 0x20] = (arg2 << 0x60) & ~((0x01 << 0x60) - 0x01);
        memory[temp0 + 0x16:temp0 + 0x16 + 0x20] = (arg3 << 0xf8) & ~((0x01 << 0xf8) - 0x01);
        return temp0 + 0x17;
    }
    
    function func_0C84(var arg0, var arg1) returns (var r0) {
        var temp0 = arg1;
        memory[temp0:temp0 + 0x20] = arg0 & (0x01 << 0xa0) - 0x01;
        return temp0 + 0x20;
    }
    
    function func_0C98(var arg0, var arg1, var arg2, var arg3) returns (var r0) {
        var temp0 = arg3;
        memory[temp0:temp0 + 0x20] = arg0 & (0x01 << 0xa0) - 0x01;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = arg1;
        memory[temp0 + 0x40:temp0 + 0x40 + 0x20] = arg2;
        return temp0 + 0x60;
    }
    
    function func_0CB9(var arg0) returns (var r0) {
        var temp0 = arg0;
        memory[temp0:temp0 + 0x20] = 0x20;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = 0x17;
        memory[temp0 + 0x40:temp0 + 0x40 + 0x20] = 0x455243313136373a2063726561746532206661696c6564000000000000000000;
        return temp0 + 0x60;
    }
    
    function func_0CF0(var arg0, var arg1) returns (var r0) {
        var temp0 = arg1;
        memory[temp0:temp0 + 0x20] = arg0;
        return temp0 + 0x20;
    }
    
    function func_0CF9(var arg0, var arg1, var arg2) returns (var r0) {
        var temp0 = arg2;
        memory[temp0:temp0 + 0x20] = arg0;
        memory[temp0 + 0x20:temp0 + 0x20 + 0x20] = arg1;
        return temp0 + 0x40;
    }
    
    function func_0D07(var arg0) returns (var r0) {
        var temp0 = memory[0x40:0x60];
        var var0 = temp0;
        var temp1 = var0 + arg0;
        var var1 = temp1;
    
        if (!((var1 < var0) | (var1 > 0xffffffffffffffff))) {
            memory[0x40:0x60] = var1;
            return var0;
        } else {
            var var2 = 0x0d29;
            memory[0x00:0x20] = 0x4e487b71 << 0xe0;
            memory[0x04:0x24] = 0x41;
            revert(memory[0x00:0x24]);
        }
    }
    
    function func_0D31(var arg0, var arg1) returns (var r0) {
        var var0 = 0x00;
    
        if (arg1 <= ~arg0) { return arg1 + arg0; }
    
        var var1 = 0x0d44;
        memory[0x00:0x20] = 0x4e487b71 << 0xe0;
        memory[0x04:0x24] = 0x11;
        revert(memory[0x00:0x24]);
    }
    
    function func_0D49(var arg0) returns (var r0) {
        var var0 = 0x00;
    
        if (arg0 != ~0x00) { return arg0 + 0x01; }
    
        var var1 = 0x0d5d;
        memory[0x00:0x20] = 0x4e487b71 << 0xe0;
        memory[0x04:0x24] = 0x11;
        revert(memory[0x00:0x24]);
    }
}