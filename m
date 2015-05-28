Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33240 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbE1PXb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 11:23:31 -0400
Received: by wgez8 with SMTP id z8so39571763wge.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 08:23:30 -0700 (PDT)
Date: Thu, 28 May 2015 17:23:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150528152315.GA31492@omega>
References: <20150528123832.GD11340@wantstofly.org>
 <20150528171315.0833a387@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150528171315.0833a387@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-wpan@vger.kernel.org

Hi,

On Thu, May 28, 2015 at 05:13:15PM +0200, Phoebe Buckheister wrote:
> On Thu, 28 May 2015 15:38:32 +0300
> Lennert Buytenhek <buytenh@wantstofly.org> wrote:
> 
> > Currently, ieee802154_random_extended_addr() has a 50% chance of
> > generating a group (multicast) address, while this function is used
> > for generating station addresses (which can't be group addresses)
> > for interfaces that don't have a hardware-provided address.
> > 
> > Also, in case get_random_bytes() generates the EUI-64 address
> > 00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
> > address, ieee802154_random_extended_addr() reacts by changing it
> > to 01:00:00:00:00:00:00:00, which is an invalid station address as
> > well, as it is a group address.
> > 
> > This patch changes the address generation procedure to grab eight
> > random bytes, treat that as an EUI-64, and then clear the Group
> > address bit and set the Locally Administered bit, which is in
> > line with how eth_random_addr() generates random EUI-48s.
> 
> Looks good to me. Even if this ends up being uneccessarily strict, we'll
> always have a huge pool of addresses we may generate.
> Note: the standard only says that the address shall be a 64 bit
> universal address (not excluding multicast), but not generating
> multicast EUIs seems like a good idea anyway.
>  

thanks Phoebe for clarify this. You both convince me to change it.

Thanks that we clarify this.

> > Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>
