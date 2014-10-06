Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:48589 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaJFLWx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 07:22:53 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so6276963wgg.30
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 04:22:52 -0700 (PDT)
Date: Mon, 6 Oct 2014 13:22:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next 1/3] ieee802154: 6lowpan: fix byteorder for
 frag tag
Message-ID: <20141006112246.GB10024@omega>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
 <A134B4A0-64A0-4E34-8F54-DBAFDC11EB22@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A134B4A0-64A0-4E34-8F54-DBAFDC11EB22@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org

Hi Marcel,

On Mon, Oct 06, 2014 at 12:42:15PM +0200, Marcel Holtmann wrote:
> Hi Alex,
> 
> > This patch fix byteorder issues with fragment tag of generation 802.15.4
> > 6LoWPAN fragment header.
> > 
> > net/ieee802154/6lowpan_rtnl.c:278:54: warning restricted __be16 degrades to integer
> > net/ieee802154/6lowpan_rtnl.c:278:18: warning: incorrect type in assignment (different base types)
> > net/ieee802154/6lowpan_rtnl.c:278:18:    expected restricted __be16 [usertype] frag_tag
> > net/ieee802154/6lowpan_rtnl.c:278:18:    got unsigned short
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > Reported-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> > net/ieee802154/6lowpan_rtnl.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 

mhhh, I thought I should apply these patches to wpan-next three. That's
why it's tagged with "wpan-next" and sent to linux-wpan only.

Just for global review and such things...

Then I will send it with a bunch of patches to linux-bluetooth (I should
change that to send pull-requests to you).

- Alex
