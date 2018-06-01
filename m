Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:51363 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFAQWD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jun 2018 12:22:03 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so2486347itj.1
        for <linux-wpan@vger.kernel.org>; Fri, 01 Jun 2018 09:22:03 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:21:53 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Kernel Soft Panic with wpan interface
Message-ID: <20180601162153.tj6iz3sxh7kgicwb@x220t>
References: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>
 <7cf3bd5d-3bbf-c378-020b-8a914d9448c1@ntnu.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cf3bd5d-3bbf-c378-020b-8a914d9448c1@ntnu.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jun 01, 2018 at 08:40:34AM +0200, David Palma wrote:
...
> > 
> > 1-- While making the skbuff over 802.15.4 in __ip6_append_data we MUST
> > reserve two bytes at the end for CRC.
> > 
> > 2-- Even after adding the MAC header and 6lowpan header we have space
> > available on top of the skb (between data and head mac_header =3D 117). So =
> > in
> > ieee802154_tx kernel can check if 2 bytes is not available at end of the
> > packet it can move the packet up to make space at the end.
> > 
> > Thanks
> > Rabi
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> Hi,
> 
> Maybe this is connected to:
> 
> - https://bugzilla.kernel.org/show_bug.cgi?id=195059 ?

I send recently a fix for that. Thanks for the very detailed testing
scripted. I could reproduce this error in my setup. It doesn't occur
afterwards anymore.

Question is here still if this is not a bug in the upper layer... I send
another question related to general transmit flow.

If nobody answers then I would go for this fix...

btw: I remember some time ago that I asking me how tail/headroom works
exactly because this reason.

- Alex
