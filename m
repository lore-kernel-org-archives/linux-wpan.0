Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:54063 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbE2I17 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:27:59 -0400
Date: Fri, 29 May 2015 11:27:57 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150529082757.GP11340@wantstofly.org>
References: <20150528123832.GD11340@wantstofly.org>
 <20150528131714.GD716@omega>
 <20150528133948.GF11340@wantstofly.org>
 <20150528144249.GF716@omega>
 <20150529031958.GL11340@wantstofly.org>
 <5568218F.3070108@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5568218F.3070108@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 10:21:35AM +0200, Stefan Schmidt wrote:

> Hello.

Hi!


> >>I am currently really unsure and looking in well-known IoT OS, if they
> >>look on this bit. But I didn't saw anything. Only that the most using
> >>the same like eth_random_addr address and fill with ff fe bit pattern.
> >>Maybe to operate with some virtual linux networking ethernet interfaces
> >>which are connected over slip and tun/tap and such things...
> >ff fe bit pattern?
> 
> What they do is mapping a EUI-48 to a EUI-64 following the guidelines from:
> 
> https://standards.ieee.org/develop/regauth/tut/eui48.pdf page 4
> 
> The two missing octets are filled in with either FF
> FE or FF FF. The padding happens after the first
> three bytes with the OUI and the rest of the
> EUI-48.

Ah yes, I remember that, I just couldn't figure
out what the 'ff fe bit pattern' remark was
referring to -- thanks for clarifying. :)
