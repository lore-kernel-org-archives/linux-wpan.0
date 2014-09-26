Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54174 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbaIZQ0W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 12:26:22 -0400
Message-ID: <542593AC.4060901@xsilon.com>
Date: Fri, 26 Sep 2014 17:26:20 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54258332.2010004@xsilon.com> <20140926153521.GA7643@omega>
In-Reply-To: <20140926153521.GA7643@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

I think we need to add some filtering so we don't process packets 
addressed to other nodes, just pass them to the promiscuous mode buffer. 
I will have a look next week at a fix.

On 26/09/14 16:35, Alexander Aring wrote:
> Hi Simon,
>
> On Fri, Sep 26, 2014 at 04:16:02PM +0100, Simon Vincent wrote:
>> I have three nodes running linux all running in promiscuous mode with ipv6
> Sorry I need to ask here, why it's in promiscuous mode? It's still
> (mainline) a WPAN device? I don't know right now what changes you did
> because at mainline state we don't have any support for running any
> device into promiscuous mode.
>
It is in promiscuous mode as the hardware does not support address 
filtering yet...
>> forwarding enabled. The kernel is built from wpan-next. The three nodes are
>> all connected directly using 802.15.4.
>>
>> Node A: fe80::203:9a00:0:a
>> Node B: fe80::203:9a00:0:b
>> Node C: fe80::203:9a00:0:c
>>
>> If from node A I ping node B I get ICMP redirects from node C. Node C also
>> forwards the packet to node B so node B receives the ping request twice.
>>
> I have also 3 nodes here, maybe I can reproduce this scenario to help
> there. Can you give me some setup steps for this?
Just setup any three nodes so they can all see each other and setup a 
wireshark sniffer.
Enable ipv6 forwarding by:
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
I guess you will also have to hack your hardware driver to put your 
hardware in promiscuous mode.

Then just do a simple ping from one node to another using link local 
addresses.
>> If I try a similar setup using ethernet instead of 802.15.4 I do not get
>> this problem.
>>
>> Has anyone else seen this?
>>
> No, I am still try to get some basic features working which should work. :-)
>
> - Alex

