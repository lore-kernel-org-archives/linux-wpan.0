Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:49096 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbeBRPVa (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 18 Feb 2018 10:21:30 -0500
Date: Sun, 18 Feb 2018 16:21:28 +0100
From: anton@picapica.im
Subject: Re: issues with at86rf212b transceiver
Message-ID: <20180218152128.GA31698@picapica.im>
References: <20180217184113.GA7717@picapica.im>
 <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On Sat, Feb 17, 2018 at 02:04:04PM -0500, Alexander Aring wrote:
> Hi,
> 
> 2018-02-17 13:41 GMT-05:00  <anton@picapica.im>:
> > Hi
> >
> > I have a transceiver at86rf212b connected to Atmel's SAMA5D2-XULT devboard.
> > It runs kernel from Atmel, based on Linux release 4.9. Maybe it's not a latest one,
> > but I checked that there are no significant changes to at86rf230 driver since then.
> >
> > So I have some issues with transceiver and at86rf230 driver module.
> > Is this driver considered production-ready, was it tested with at86rf212b?
> >
> 
> So far I know somebody already use the driver with an at86rf212b -
> there was patches related to that.
> 
> What do you mean with "production-ready"? GPL gives you no warranty
> and we do it as "hobby"...
> 
> According your problem, show me "cat /proc/interrupts" I will see if
> the interrupt is fired (more than one time), otherwise I see a board
> setup problem...
> 
> - Alex

Hi Alex,

Of course I understand about no warranty, just asking. Quality of drivers
accepted into mainline kernely may vary, especially for rare hardware.
I am ready to cooperate and help with improving this driver.

Btw, I've googled thread from this mailing list
https://www.spinics.net/lists/linux-wpan/msg02555.html
"ping6 doesn't use at86rf230 driver"
with somewhat similar issues, but it was spi driver's fault. Not sure if it's
the same reason here, any ideas?

Ok, so I've started one of the dev board, looks like 12 interrupts are fired,
then something breaks and seems no more frames are sent, as interrupts count 
does not update and TX bytes value of wpan0 remains 352

Interrupt line from /proc/interrupts should be this one:
161:          0      GPIO 109 Level     spi32765.0

at86rf230 spi32765.0: Detected at86rf212 chip version 3
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state: 0x01

<skipped..>

Welcome to Buildroot
buildroot login: root
# cat /proc/interrupts 
           CPU0       
 16:        134  atmel-aic5   3 Level     at91_tick
 18:          0  atmel-aic5  42 Level     atmel_usba_udc
 19:          1  atmel-aic5  41 Level     ehci_hcd:usb1, ohci_hcd:usb2
 21:        344  atmel-aic5  31 Level     mmc0
 22:        689  atmel-aic5  32 Level     mmc1
 23:          0  atmel-aic5  46 Level     atmel_isc
 24:         40  atmel-aic5   6 Level     at_xdmac
 25:          0  atmel-aic5   7 Level     at_xdmac
 26:          1  atmel-aic5  74 Level     at91_rtc
 27:          0  atmel-aic5  12 Level     atmel-sha
 28:          0  atmel-aic5   9 Level     atmel-aes
 29:          8  atmel-aic5  33 Level     f8000000.spi
 30:          0  atmel-aic5   5 Level     eth0
 31:          0  atmel-aic5  66 Level     eth0
 32:          0  atmel-aic5  67 Level     eth0
 33:        583  atmel-aic5  35 Level     tc_clkevt
 35:        116  atmel-aic5  25 Level     ttyS0
 36:       1985  atmel-aic5  29 Level     f8028000.i2c
 40:         37  atmel-aic5  34 Level     fc000000.spi
 42:         34  atmel-aic5  30 Level     fc028000.i2c
 43:          0  atmel-aic5  40 Level     at91-sama5d2_adc
 48:          0  atmel-aic5  11 Level     atmel-tdes
 83:          0      GPIO  31 Edge      atmel_usba_udc
 97:          0      GPIO  45 Edge      act8945a_interrupt
124:          0      GPIO  72 Edge      act8945a_lbo_detect
125:          0      GPIO  73 Level     phy_interrupt
161:          0      GPIO 109 Level     spi32765.0
Err:          0
# random: crng init done

# iwpan phy phy0 set channel 0 0
# iwpan dev wpan0 set pan_id 0xbeef
# iwpan dev wpan0 set short_addr 0x0001
# ip link add link wpan0 name lowpan0 type lowpan
# ip link set wpan0 up
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x16. Actual state: 0x01
# cat /proc/interrupts 
           CPU0       
 16:        134  atmel-aic5   3 Level     at91_tick
 18:          0  atmel-aic5  42 Level     atmel_usba_udc
 19:          1  atmel-aic5  41 Level     ehci_hcd:usb1, ohci_hcd:usb2
 21:        344  atmel-aic5  31 Level     mmc0
 22:       1114  atmel-aic5  32 Level     mmc1
 23:          0  atmel-aic5  46 Level     atmel_isc
 24:        190  atmel-aic5   6 Level     at_xdmac
 25:          0  atmel-aic5   7 Level     at_xdmac
 26:          1  atmel-aic5  74 Level     at91_rtc
 27:          0  atmel-aic5  12 Level     atmel-sha
 28:          0  atmel-aic5   9 Level     atmel-aes
 29:          8  atmel-aic5  33 Level     f8000000.spi
 30:          0  atmel-aic5   5 Level     eth0
 31:          0  atmel-aic5  66 Level     eth0
 32:          0  atmel-aic5  67 Level     eth0
 33:       3438  atmel-aic5  35 Level     tc_clkevt
 35:        701  atmel-aic5  25 Level     ttyS0
 36:       1985  atmel-aic5  29 Level     f8028000.i2c
 40:         62  atmel-aic5  34 Level     fc000000.spi
 42:         34  atmel-aic5  30 Level     fc028000.i2c
 43:          0  atmel-aic5  40 Level     at91-sama5d2_adc
 48:          0  atmel-aic5  11 Level     atmel-tdes
 83:          0      GPIO  31 Edge      atmel_usba_udc
 97:          0      GPIO  45 Edge      act8945a_interrupt
124:          0      GPIO  72 Edge      act8945a_lbo_detect
125:          0      GPIO  73 Level     phy_interrupt
161:          0      GPIO 109 Level     spi32765.0
Err:          0
# ip link set lowpan0 up
# at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x19. Actual state: 0x0c
at86rf230 spi32765.0: not supported irq 84 received
------------[ cut here ]------------
WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
received tx trac status 4
Modules linked in: ov7670 atmel_usba_udc
CPU: 0 PID: 61 Comm: spi32765 Not tainted 4.9.52-linux4sam_5.7 #1
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
---[ end trace f3c9010c70b3c7af ]---
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x16. Actual state: 0x0b
at86rf230 spi32765.0: unexcept state change from 0x0b to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x19. Actual state: 0x01
at86rf230 spi32765.0: not supported irq 84 received
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x16. Actual state: 0x0b
at86rf230 spi32765.0: unexcept state change from 0x0b to 0x09. Actual state: 0x04
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x19. Actual state: 0x01
------------[ cut here ]------------
WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:754 0xc0442528
received rx trac status 4
Modules linked in: ov7670 atmel_usba_udc
CPU: 0 PID: 61 Comm: spi32765 Tainted: G        W       4.9.52-linux4sam_5.7 #1
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
---[ end trace f3c9010c70b3c7b0 ]---
at86rf230 spi32765.0: unexcept state change from 0x0c to 0x09. Actual state: 0x04
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x16. Actual state: 0x0b
at86rf230 spi32765.0: unexcept state change from 0x0b to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x19. Actual state: 0x01
at86rf230 spi32765.0: not supported irq 80 received
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x16. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x04
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x19. Actual state: 0x0c
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x16. Actual state: 0x0b
at86rf230 spi32765.0: unexcept state change from 0x01 to 0x09. Actual state: 0x01
at86rf230 spi32765.0: unexcept state change from 0x04 to 0x19. Actual state: 0x01
at86rf230 spi32765.0: not supported irq 84 received
at86rf230 spi32765.0: not supported irq 80 received

# cat /proc/interrupts 
           CPU0       
 16:        134  atmel-aic5   3 Level     at91_tick
 18:          0  atmel-aic5  42 Level     atmel_usba_udc
 19:          1  atmel-aic5  41 Level     ehci_hcd:usb1, ohci_hcd:usb2
 21:        344  atmel-aic5  31 Level     mmc0
 22:       1211  atmel-aic5  32 Level     mmc1
 23:          0  atmel-aic5  46 Level     atmel_isc
 24:        252  atmel-aic5   6 Level     at_xdmac
 25:          0  atmel-aic5   7 Level     at_xdmac
 26:          1  atmel-aic5  74 Level     at91_rtc
 27:          0  atmel-aic5  12 Level     atmel-sha
 28:          0  atmel-aic5   9 Level     atmel-aes
 29:          8  atmel-aic5  33 Level     f8000000.spi
 30:          0  atmel-aic5   5 Level     eth0
 31:          0  atmel-aic5  66 Level     eth0
 32:          0  atmel-aic5  67 Level     eth0
 33:       4110  atmel-aic5  35 Level     tc_clkevt
 35:        886  atmel-aic5  25 Level     ttyS0
 36:       1985  atmel-aic5  29 Level     f8028000.i2c
 40:        147  atmel-aic5  34 Level     fc000000.spi
 42:         34  atmel-aic5  30 Level     fc028000.i2c
 43:          0  atmel-aic5  40 Level     at91-sama5d2_adc
 48:          0  atmel-aic5  11 Level     atmel-tdes
 83:          0      GPIO  31 Edge      atmel_usba_udc
 97:          0      GPIO  45 Edge      act8945a_interrupt
124:          0      GPIO  72 Edge      act8945a_lbo_detect
125:          0      GPIO  73 Level     phy_interrupt
161:         12      GPIO 109 Level     spi32765.0
Err:          0
# ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lowpan0   Link encap:UNSPEC  HWaddr D6-60-8E-A9-17-93-48-5C-00-00-00-00-00-00-00-00  
          inet6 addr: fe80::d460:8ea9:1793:485c/64 Scope:Link
          inet6 addr: fe80::bcef:ff:fe00:1/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:728 (728.0 B)

wpan0     Link encap:UNSPEC  HWaddr D6-60-8E-A9-17-93-48-5C-00-00-00-00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:0 (0.0 B)  TX bytes:352 (352.0 B)

# wpan-ping -a 0x0002
PING 0x0002 (PAN ID 0xbeef) 5 data bytes
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
^C
# cat /proc/interrupts 
           CPU0       
 16:        134  atmel-aic5   3 Level     at91_tick
 18:          0  atmel-aic5  42 Level     atmel_usba_udc
 19:          1  atmel-aic5  41 Level     ehci_hcd:usb1, ohci_hcd:usb2
 21:        344  atmel-aic5  31 Level     mmc0
 22:       1346  atmel-aic5  32 Level     mmc1
 23:          0  atmel-aic5  46 Level     atmel_isc
 24:        307  atmel-aic5   6 Level     at_xdmac
 25:          0  atmel-aic5   7 Level     at_xdmac
 26:          1  atmel-aic5  74 Level     at91_rtc
 27:          0  atmel-aic5  12 Level     atmel-sha
 28:          0  atmel-aic5   9 Level     atmel-aes
 29:          8  atmel-aic5  33 Level     f8000000.spi
 30:          0  atmel-aic5   5 Level     eth0
 31:          0  atmel-aic5  66 Level     eth0
 32:          0  atmel-aic5  67 Level     eth0
 33:       4843  atmel-aic5  35 Level     tc_clkevt
 35:       1035  atmel-aic5  25 Level     ttyS0
 36:       1985  atmel-aic5  29 Level     f8028000.i2c
 40:        147  atmel-aic5  34 Level     fc000000.spi
 42:         34  atmel-aic5  30 Level     fc028000.i2c
 43:          0  atmel-aic5  40 Level     at91-sama5d2_adc
 48:          0  atmel-aic5  11 Level     atmel-tdes
 83:          0      GPIO  31 Edge      atmel_usba_udc
 97:          0      GPIO  45 Edge      act8945a_interrupt
124:          0      GPIO  72 Edge      act8945a_lbo_detect
125:          0      GPIO  73 Level     phy_interrupt
161:         12      GPIO 109 Level     spi32765.0
Err:          0
# ifconfig
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lowpan0   Link encap:UNSPEC  HWaddr D6-60-8E-A9-17-93-48-5C-00-00-00-00-00-00-00-00  
          inet6 addr: fe80::d460:8ea9:1793:485c/64 Scope:Link
          inet6 addr: fe80::bcef:ff:fe00:1/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:944 (944.0 B)

wpan0     Link encap:UNSPEC  HWaddr D6-60-8E-A9-17-93-48-5C-00-00-00-00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:0 (0.0 B)  TX bytes:352 (352.0 B)

#
