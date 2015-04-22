Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from vpn-da.werderstrasse.de ([217.195.43.101]:42576 "EHLO
	sinabox.bfst.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933552AbbDVG5P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Apr 2015 02:57:15 -0400
Message-ID: <55374646.90509@ruecker.fi>
Date: Wed, 22 Apr 2015 09:57:10 +0300
From: =?UTF-8?B?IlRob21hcyBCLiBSw7xja2VyIg==?= <thomas@ruecker.fi>
MIME-Version: 1.0
Subject: Re: at86rf233 on BeagleBone Black
References: <551EDFCA.3070905@fid4.com> <20150403191320.GD773@omega> <20150414150656.GB2179@omega> <553024C3.2020207@fid4.com> <55307D66.7020606@gmail.com> <55310A85.5080601@fid4.com> <20150417221913.GA3338@omega> <55353FC0.5050909@fid4.com> <5535FAE4.60302@ruecker.fi>
In-Reply-To: <5535FAE4.60302@ruecker.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>, Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On 21/04/15 10:23, "Thomas B. Rücker" wrote:
> On 04/20/2015 06:04 PM, Michael C. Cambria wrote:
>> I'll test e..g ping6 to another BBB and Pi ASAP.
> Yeah, still have to test mine too. Started working on wiring another
> openlabs module into a Minnowboard Max, but that needs writing a board
> file...
> I think I'll first just flash one of my CC2530 nodes for some simple tests.

I've tried two things:
- Receiving packets from cc2530 nodes running contiki in monitor mode.
   For some reason Wireshark complains about the FCS on some packets.
- Beaglebone White and a BB Black (same image, both DTBs patched)
   works just fine, #exactsteps below

Boards run a Debian Jessie image with a 4.0 Linux kernel built using 
RCN's tools. From what I can tell it's pretty low on patches, so 
~vanilla. DT for both am335x-bone and am335x-boneblack modified to 
include a DTSI, similar to what Alex posted e.g. in 
<20150414150656.GB2179@omega>. DT for BBB disabled HDMI. wpan-tools from 
git.

Board1:
# iwpan dev wpan0 set pan_id 0xcafe
# ip link add link wpan0 name lowpan0 type lowpan
# ip -6 addr add 2001:db8::1/64 dev lowpan0
# ip link set wpan0 up
# ip link set lowpan0 up

Board2:
# iwpan dev wpan0 set pan_id 0xcafe
# ip link add link wpan0 name lowpan0 type lowpan
# ip -6 addr add 2001:db8::2/64 dev lowpan0
# ip link set wpan0 up
# ip link set lowpan0 up
# ping6 2001:db8::1 -c3
PING 2001:db8::1(2001:db8::1) 56 data bytes
64 bytes from 2001:db8::1: icmp_seq=1 ttl=64 time=10.8 ms
64 bytes from 2001:db8::1: icmp_seq=2 ttl=64 time=10.5 ms
64 bytes from 2001:db8::1: icmp_seq=3 ttl=64 time=10.5 ms

--- 2001:db8::1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 10.526/10.633/10.814/0.175 ms

Tried SSH, works fine too.

If you are concerned with TCP performance you can modify parameters 
according to Alex:
#reduce tcp receive buf, will improve tcp connections
echo "127 512 1024" > /proc/sys/net/ipv4/tcp_rmem
echo "127 512 1024" > /proc/sys/net/ipv4/tcp_wmem

Note that this will affect the whole TCP stack. There might be a way to 
do it per interface.


Next: try to talk to the Contiki nodes properly

Cheers

Thomas


