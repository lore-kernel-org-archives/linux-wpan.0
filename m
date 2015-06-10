Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37376 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbFJIo2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 04:44:28 -0400
Received: by wifx6 with SMTP id x6so39659959wif.0
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 01:44:27 -0700 (PDT)
Date: Wed, 10 Jun 2015 10:44:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: nl802154 enum misspelled, just send patch?
Message-ID: <20150610084424.GB947@omega>
References: <20150610082449.GA20831@arazu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150610082449.GA20831@arazu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 10:24:49AM +0200, Christoffer Holmstedt wrote:
> Hi
> While working on the CCA improvements to wpan-tools I noticed that one of the
> enums has a value misspelled. As the header is not in UAPI yet I suggest we
> fix this.
> 
> NL802154_CCA_UWB_MULTIPEXED is missing an l (ell) in multiplexed.
> 
> The header file is included in wpan-tools repository and available in the
> kernel. Should I just send a patch for bluetooth-next and then the new header
> file is copied over to wpan-tools repository or what is the procedure here?
> 

First send patches for kernel, when Marcel has applied the change. Then
you can send another patch for wpan-tools for updating the nl802154 header.

> I assume normal procedure for more "stable" user-space software is that the
> kernel header file(s) should not be included in the user-space tool but instead
> included and linked against the kernel headers (from running system or similiar
> source). At the moment the nl802154 header is included in wpan-tools to make it
> easier to build while developing.
> 

In this case, if we would change the uapi header then compiling will
fail, because the enum is different. In this case it's safer to put the
header in wpan-tools.

If the kernel get a enum value which is higher than the own nl802154
capabilities, this should be handled by nl802154 by checking on ATTR_MAX
value.

> So, should I send a patch for both bluetooth-next and wpan-tools or just
> bluetooth-next?
> 

API changes are always bad, but this doesn't change the API. It's just a
compile failure when we change it. So it's okay to fix that now. 

So first send patches to bluetooth-next then wpan-tools with updating
nl802154 header and also updating your cca print functionality. Maybe
mention the bluetooth-next commit id in the commit msg of wpan-tools patch.

- Alex
