Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:61548 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcD2RMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 Apr 2016 13:12:19 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [riot-devel] RIOT+ULAs: no router entry
From: smlng <s@mlng.net>
In-Reply-To: <20160429152458.GA15676@omega>
Date: Fri, 29 Apr 2016 19:06:05 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <B6491655-6980-4E77-A525-B24749C44129@mlng.net>
References: <B354489C-54BF-4CAF-8B41-04A946D83478@mlng.net> <20160422102833.GA5671@omega> <7BCB9BD8-C255-458C-83F6-0F7FE69F5C7F@mlng.net> <20160422122816.GA6364@omega> <20160424200528.GA27492@omega> <20160424203128.GA27936@omega> <3CFBDFC0-3AB2-4931-8BCB-B034EBDC0B9C@mlng.net> <20160429152458.GA15676@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: RIOT OS kernel developers <devel@riot-os.org>
Cc: linux-wpan@vger.kernel.org

Hi Alex, and all,

> Am 29.04.2016 um 17:25 schrieb Alexander Aring <alex.aring@gmail.com>:
> 
> Routers are indicated by the "forwarding" setting. radvd silent warns
> about that if this isn't set for interfaces with RA advert is on, so far I
> know you need to increase the debug level for that.
> 
> I simple set:
> 
> echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
> 
> this will set forwarding for all interfaces.
> 
> Some code explaining:
> 
> See http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L838
> 
> this is at function when NS is received, the routeri flag will be set when
> forwarding is enabled.
> 
> Maybe this solves all your current issues. :-)

Yep, thanks - that did the trick. 

I wonder why it isn't sufficient to set 'echo 1 > /proc/sys/net/ipv6/conf/lowpan0/forwarding' on that specific lowpan interface? I tried it, but `radvd` still complains (debug level 5) that forwarding is 0. However, it works by enabling it for all IPv6 interfaces as you suggested.

> 
>> I'm running latest Raspbian with Kernel 'Linux raspberrypi 4.1.19+' and wpan-tools from github on the RasPi.
>> 
> 
> I would better use bluetooth-next, if possible. With all recent patches
> you could also try to use 6CO in radvd.

mhm, I'm using default Raspbian with RPI-Linux+DTS-overlay 'at86rf233' as it is cause a fast and easy setup - and until now, this was sufficient for my test cases ...

Best,
 Sebastian

[mail]: s@mlng.net
[code]: https://github.com/smlng

