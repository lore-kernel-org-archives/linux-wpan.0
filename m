Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37331 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbLKROB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 11 Dec 2015 12:14:01 -0500
Date: Fri, 11 Dec 2015 18:13:53 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 4/4] 6lowpan: iphc: add support for
 stateful compression
Message-ID: <20151211171352.GA25972@omega>
References: <1448796882-316-1-git-send-email-alex.aring@gmail.com>
 <1448796882-316-5-git-send-email-alex.aring@gmail.com>
 <20151211170541.GA1119@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151211170541.GA1119@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de

On Fri, Dec 11, 2015 at 06:05:41PM +0100, Alexander Aring wrote:
> Hi,
> 
> status update here.
> 
> I implemented successful basic 6CO RA messages at sending and
> processing inside radvd.
> 
> There might also the question if processing 6CO inside kernel or
> userspace? I put the basic functionality inside userspace for now.
> 
> I will send patches for this in the next days.
> 
> Anyway I figured some things out which was completely wrong inside this
> patch.
> 
>  - There exist one context based table only.
>    
>    In rfc6282 stands:
>    The specification enables a node to use up to 16 contexts. The
>    context used to encode the source address does not have to be the
>    same as the context used to encode the destination address.
> 
>    and I thought it was $SOME_TABLE[DCI] != $DIFFERENT_TABLE[SCI].

in case of SCI == DCI.

>    But it means in general simple that it can be: DCI != SCI.
> 
>    With this knowledge the code gets much smaller.
> 
>  - I also remove the validation check for contexts, it can be any
>    prefic/address. The lookup functionality will deal with that if the
>    context looks not correct or need additional changes.
> 

  - Also I renamed the "enabled" to "C" which is the compression flag of
    6CO.

- Alex
