Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36343 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786AbbDIKVd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 06:21:33 -0400
Received: by wizk4 with SMTP id k4so86540374wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 03:21:32 -0700 (PDT)
Date: Thu, 9 Apr 2015 12:21:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan on a RPi using at86rf233
Message-ID: <20150409102126.GE1261@omega>
References: <20150403143647.GA6266@bogon.m.sigxcpu.org>
 <20150403144459.GA773@omega>
 <20150403182744.GA8360@bogon.m.sigxcpu.org>
 <20150403183804.GB773@omega>
 <20150407114921.GA3390@bogon.m.sigxcpu.org>
 <20150407190749.GG16415@omega>
 <20150409090652.GA5018@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150409090652.GA5018@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Apr 09, 2015 at 11:06:52AM +0200, Guido Günther wrote:
> 
> SSHing between the machines is ok. Nice.

For tune-up tcp connection I set also set tcp window size;

#reduce tcp receive buf, will improve tcp connections
echo "127 512 1024" > /proc/sys/net/ipv4/tcp_rmem
echo "127 512 1024" > /proc/sys/net/ipv4/tcp_wmem

This will do this for all tcp connection. You can also try to set MSS
with ip6tables.

to have much fragments isn't good on a 6LoWPAN connection. Upper layers
like CoAP, etc. will handle this. Also a general TCP connection isn't
good, because the ACK handling stuff. Maybe want to try out "mosh with
ipv6 support [1]" - currently only available on dev branch.


High fragments and fq_codel qdisc will also occur trouble, because the
skb's are too long inside the queue and fq_codel will drop them then.
This occurs on my setup at payload of ~2000 bytes, but we should never
reach such payload, also 1024 is too high. If you use with contiki I
don't think that contiki implement ipv6 fragmentation, so you can set
the highest payload to 1280. Does somebody knows if contiki supports
ipv6 fragmentation?

- Alex

[1] https://github.com/keithw/mosh
