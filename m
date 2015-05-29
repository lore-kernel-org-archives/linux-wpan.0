Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33288 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbbE2IVi (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 May 2015 04:21:38 -0400
Message-ID: <5568218F.3070108@osg.samsung.com>
Date: Fri, 29 May 2015 10:21:35 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
References: <20150528123832.GD11340@wantstofly.org> <20150528131714.GD716@omega> <20150528133948.GF11340@wantstofly.org> <20150528144249.GF716@omega> <20150529031958.GL11340@wantstofly.org>
In-Reply-To: <20150529031958.GL11340@wantstofly.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 29/05/15 05:19, Lennert Buytenhek wrote:
> On Thu, May 28, 2015 at 04:42:53PM +0200, Alexander Aring wrote:
>
>
>> I am currently really unsure and looking in well-known IoT OS, if they
>> look on this bit. But I didn't saw anything. Only that the most using
>> the same like eth_random_addr address and fill with ff fe bit pattern.
>> Maybe to operate with some virtual linux networking ethernet interfaces
>> which are connected over slip and tun/tap and such things...
> ff fe bit pattern?

What they do is mapping a EUI-48 to a EUI-64 following the guidelines from:

https://standards.ieee.org/develop/regauth/tut/eui48.pdf page 4

The two missing octets are filled in with either FF FE or FF FF. The 
padding happens after the first three bytes with the OUI and the rest of 
the EUI-48.

regards
Stefan Schmidt
