Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:35831 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEFJMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 05:12:35 -0400
Received: by labbd9 with SMTP id bd9so2727194lab.2
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 02:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5549DA61.2040201@gmail.com>
References: <CAG9Fz+vEia1W-hCnthVtWwoJzkHvdh2wm9uz9XxnCBLbxpLp+Q@mail.gmail.com>
	<5549DA61.2040201@gmail.com>
Date: Wed, 6 May 2015 14:42:33 +0530
Message-ID: <CAEUmHybZwH0SxYV5HYhFKDBp4ZBKFG8iQzpe_xcBzzcs7Tf8=A@mail.gmail.com>
Subject: Fwd: RPi, Raspbian with openlabs transceiver - lib/tool versions and
 updated instructions(?)
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On 05/06/2015 12:57 PM, Christoffer Holmstedt wrote:

I'm currently setting up my dev/test environment to get a "default"
working state to build upon but have stumbled upon some issues on the
way. I'm currently running Raspbian with latest bluetooth-next kernel.
U-Boot from last november. For libnl I use the default packages
available in Raspbian repository. wpan-tools I've checked out the 0.4
release from git repository.

U-Boot: 2014-11-10 [1]
Raspbian version: 2015-02-16 (originally built with 3.18 kernel)
Bluetooth-next kernel 4.1.0-rc1+ 2015-04-30 [2]
libnl-3-dev version: 3.2.7-4 (Raspbian repository)
libnl-genl-3-dev version: 3.2.7-4 (Raspbian repository)
wpan-tools (tag: wpan-tools-0.4) [3]

Is this set of libraries/tools ever going to work together or do I
have an obvious mismatch that will for sure fail?

### command failed: Device or resource busy (-16)
The problem I have now is that when I try to set pan_id as described
on wpan.cakelab.org I get "resource is busy" error. I also have two
wpan interfaces which I'm not sure is what I should expect, as only
one transceiver is connected to the RPi.

$ sudo iwpan --debug dev wpan0 set pan_id 0xbeef (almost identical
response for wpan1)
-- Debug: Sent Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [HEADER] 16 octets
    .nlmsg_len = 36
    .nlmsg_type = 21 <0x15>
    .nlmsg_flags = 5 <REQUEST,ACK>
    .nlmsg_seq = 1430895752
    .nlmsg_pid = 12459
  [PAYLOAD] 20 octets
    0a 00 00 00 08 00 03 00 02 00 00 00 06 00 09 00 ef be ..................
    00 00                                                 ..
---------------------------  END NETLINK MESSAGE   ---------------------------
-- Debug: Received Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [HEADER] 16 octets
    .nlmsg_len = 56
    .nlmsg_type = 2 <ERROR>
    .nlmsg_flags = 0 <>
    .nlmsg_seq = 1430895752
    .nlmsg_pid = 12459
  [ERRORMSG] 20 octets
    .error = -16 "Device or resource busy"
  [ORIGINAL MESSAGE] 16 octets
    .nlmsg_len = 16
    .nlmsg_type = 21 <0x15>
    .nlmsg_flags = 5 <REQUEST,ACK>
    .nlmsg_seq = 1430895752
    .nlmsg_pid = 12459
---------------------------  END NETLINK MESSAGE   ---------------------------
command failed: Device or resource busy (-16)

### iwpan dev and ifconfig gives me the following information:
$ iwpan dev
phy#1
    Interface wpan1
        ifindex 3
        wpan_dev 0x100000001
        extended_addr 0x4507b443ff180a33
        short_addr 0xffff
        pan_id 0xffff
        type node
        max_frame_retries -1
        min_be 3
        max_be 5
        max_csma_backoffs 4
        lbt 0
phy#0
    Interface wpan0
        ifindex 2
        wpan_dev 0x1
        extended_addr 0x0000000000000000
        short_addr 0xffff
        pan_id 0xffff
        type node
        max_frame_retries -1
        min_be 3
        max_be 5
        max_csma_backoffs 4
        lbt 0

$ ifconfig
wpan0     Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wpan1     Link encap:UNSPEC  HWaddr
45-07-B4-43-FF-18-0A-33-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

### Instructions available
The most up to date instructions I have found are from august last
year and outdated (openlabs.co), has anyone else written a blog post
or similar on how to get a working setup running?

[1] https://github.com/swarren/u-boot/tree/4f70244e0a1a0d68cf3c5493998ff3565f38d825
[2] https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=1add15646672ff4e7fe59bec2afcb5a0c80c5e49
[3] https://github.com/linux-wpan/wpan-tools/releases/tag/wpan-tools-0.4

Regards

Similar issue faced by the community previously. see thread at [1].

The surprising thing is you got two interfaces for single h/w device.

Guido Günther wrote a blog at [2] for setup.

[1]: http://www.spinics.net/lists/linux-wpan/msg01593.html
[2]: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

-- 
Varka Bhadram
