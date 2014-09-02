Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53848 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaIBQGe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 12:06:34 -0400
Message-ID: <5405EB08.5040006@xsilon.com>
Date: Tue, 02 Sep 2014 17:06:32 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com> <20140901113835.GA21564@omega> <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com> <20140902071214.GA25800@omega> <20140902072627.GB25800@omega> <5405D284.7020606@xsilon.com> <20140902144327.GA15189@omega> <5405D961.4060006@xsilon.com> <20140902153742.GC15189@omega>
In-Reply-To: <20140902153742.GC15189@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

This is not a problem. There is a fix elsewhere for that.

I am using local-link addresses.

I am seeing funny things like:
lowpan0: received packet from fe80::203:9a00:41:c864 -> 
7707:ffff:300:0:9a:300:7b3b:3a1a

Src address fe80::203:9a00:41:c864 does not exist on the network and 
destination address 7707:ffff:300:0:9a:300:7b3b:3a1a does not.

I will play around with different socket options and see if that makes a 
difference.

Simon

On 02/09/14 16:37, Alexander Aring wrote:
> Hi Simon,
>
> I saw this right now [0].
>
> This is how an eui48 is converted to eui64. But we have already a
> neui64. Are you sure this code check on this?
>
> Normally it should check if the dev addr_len is 64 bit long, then it's a
> eui64 address.
>
> I don't see any test on this. That's why it works on a ethernet device
> and not on a 802.15.4 lowpan device type.
>
> - Alex
>
> [0] https://github.com/smee204/unstrung/blob/all_fixes/lib/libndmgmt/iface.cpp#L91

