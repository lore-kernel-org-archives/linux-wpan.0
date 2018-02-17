Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:42719 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBQSlP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 17 Feb 2018 13:41:15 -0500
Date: Sat, 17 Feb 2018 19:41:13 +0100
From: anton@picapica.im
Subject: issues with at86rf212b transceiver
Message-ID: <20180217184113.GA7717@picapica.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi

I have a transceiver at86rf212b connected to Atmel's SAMA5D2-XULT devboard.
It runs kernel from Atmel, based on Linux release 4.9. Maybe it's not a latest one,
but I checked that there are no significant changes to at86rf230 driver since then.

So I have some issues with transceiver and at86rf230 driver module. 
Is this driver considered production-ready, was it tested with at86rf212b?

I turn on two devboards with transceiver attached, both have same linux distro with same
kernel version and wpan-tools.

device tree snippet:

                        spi1: spi@fc000000 {
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <&pinctrl_spi1_default>;
                                transceiver@0 {
                                        compatible = "atmel,at86rf212";
                                        spi-max-frequency = <7500000>;
                                        reg = <0>;
                                        interrupt-parent = <&pioA>;
                                        interrupts = <109 GPIO_ACTIVE_HIGH>;
                                        reset-gpio = <&pioA 41 GPIO_ACTIVE_LOW>;
                                        sleep-gpio =<&pioA 125 GPIO_ACTIVE_HIGH>;
                                        status = "okay";
                                        pinctrl-names = "default";
                                        pinctrl-0 = <&pinctrl_transceiver_irq &pinctrl_transceiver_rst &pinctrl_transceiver_slp>;
                                };
                        };

                        flx4: flexcom@fc018000 {

                                i2c2: i2c@600 {
                                        status = "disable"; /* conflicts with transceiver, pin PD13 */
                                };
                        };

                        pinctrl@fc038000 {
                                pinctrl_spi1_default: spi1_default {
                                        pinmux = <PIN_PD25__SPI1_SPCK>,
                                                 <PIN_PD26__SPI1_MOSI>,
                                                 <PIN_PD27__SPI1_MISO>,
                                                 <PIN_PD28__SPI1_NPCS0>;
                                        bias-disable;
                                };

                                pinctrl_transceiver_irq: transceiver_irq {
                                        pinmux = <PIN_PD13__GPIO>;
                                        bias-disable;
                                };

                                pinctrl_transceiver_rst: transceiver_rst {
                                        pinmux = <PIN_PB9__GPIO>;
                                        bias-pull-up;
                                };

                                pinctrl_transceiver_slp: transceiver_slp {
                                        pinmux = <PIN_PD29__GPIO>;
                                        bias-disable;
                                };

When I try to enable lowpan interface, I get lot of kernel messages in console, on both
devices, then kernel messages stop and no data is exchanged, sent and received bytes counters displayed by ifconfig
do not update no matter what I try (wpan-ping, ping6, etc). Seems that driver hangs or deadlocks after kernel messages

at86rf230 spi32765.0: not supported irq 84 received
at86rf230 spi32765.0: not supported irq 80 received



buildroot login: root
# iwpan phy phy0 set channel 0 0
# iwpan dev wpan0 set pan_id 0xbeef
# iwpan dev wpan0 set short_addr 0x0002
# ip link add link wpan0 name lowpan0 type lowpan
# ip link set wpan0 up
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x16. Actual state: 0x01
# at86rf230 spi32765.0: not supported irq 84 received
------------[ cut here ]------------
WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:754 0xc0442528
received rx trac status 4
Modules linked in: ov7670 atmel_usba_udc
CPU: 0 PID: 61 Comm: spi32765 Not tainted 4.9.52-linux4sam_5.7 #1
Hardware name: Atmel SAMA5
Function entered at [<c010ce64>] from [<c010a6c4>]
Function entered at [<c010a6c4>] from [<c0116744>]
Function entered at [<c0116744>] from [<c0116794>]
Function entered at [<c0116794>] from [<c0442528>]
Function entered at [<c0442528>] from [<c042ceec>]
Function entered at [<c042ceec>] from [<c042b5f0>]
Function entered at [<c042b5f0>] from [<c012f268>]
Function entered at [<c012f268>] from [<c012f138>]
Function entered at [<c012f138>] from [<c0107458>]
---[ end trace 8d01f5f6ebae868e ]---
at86rf230 spi32765.0: not supported irq 80 received

# ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wpan0     Link encap:UNSPEC  HWaddr 9A-54-66-3E-CC-20-1B-3B-00-00-00-00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:107 (107.0 B)  TX bytes:0 (0.0 B)

# ip link set lowpan0 up
# at86rf230 spi32765.0: unexcept state change from 0x0b to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x19. Actual state: 0x01
at86rf230 spi32765.0: not supported irq 80 received
------------[ cut here ]------------
WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
received tx trac status 4
Modules linked in: ov7670 atmel_usba_udc
CPU: 0 PID: 61 Comm: spi32765 Tainted: G        W       4.9.52-linux4sam_5.7 #1
Hardware name: Atmel SAMA5
Function entered at [<c010ce64>] from [<c010a6c4>]
Function entered at [<c010a6c4>] from [<c0116744>]
Function entered at [<c0116744>] from [<c0116794>]
Function entered at [<c0116794>] from [<c0442644>]
Function entered at [<c0442644>] from [<c042ceec>]
Function entered at [<c042ceec>] from [<c042b5f0>]
Function entered at [<c042b5f0>] from [<c012f268>]
Function entered at [<c012f268>] from [<c012f138>]
Function entered at [<c012f138>] from [<c0107458>]
---[ end trace 8d01f5f6ebae868f ]---
at86rf230 spi32765.0: unexcept state change from 0x0c to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x16. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x0b to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x19. Actual state: 0x01
at86rf230 spi32765.0: not supported irq 84 received
at86rf230 spi32765.0: not supported irq 80 received

# ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lowpan0   Link encap:UNSPEC  HWaddr 9A-54-66-3E-CC-20-1B-3B-00-00-00-00-00-00-00-00  
          inet6 addr: fe80::9854:663e:cc20:1b3b/64 Scope:Link
          inet6 addr: fe80::bcef:ff:fe00:2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:584 (584.0 B)

wpan0     Link encap:UNSPEC  HWaddr 9A-54-66-3E-CC-20-1B-3B-00-00-00-00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:107 (107.0 B)  TX bytes:111 (111.0 B)
