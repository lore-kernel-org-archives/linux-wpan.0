Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33338 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbIAHjL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 1 Sep 2015 03:39:11 -0400
Received: by wicmc4 with SMTP id mc4so22805751wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 01 Sep 2015 00:39:10 -0700 (PDT)
Date: Tue, 1 Sep 2015 09:39:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 bluetooth-next 13/16] ieee802154: 6lowpan: add check for
 reserved dispatch
Message-ID: <20150901073906.GB1454@omega>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-14-git-send-email-alex.aring@gmail.com>
 <55E37D16.8010901@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55E37D16.8010901@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Mon, Aug 31, 2015 at 12:00:54AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 20/08/15 18:47, Alexander Aring wrote:
> >This patch adds checks for reserved dispatch value. When we have a
> >reserved dispatch value we should drop the skb immediately.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  net/ieee802154/6lowpan/rx.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> >index d309d91..f98ebf5 100644
> >--- a/net/ieee802154/6lowpan/rx.c
> >+++ b/net/ieee802154/6lowpan/rx.c
> >@@ -260,6 +260,17 @@ static inline bool lowpan_is_nalp(u8 dispatch)
> >  	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
> >  }
> >+/* Lookup for reserved dispatch values at:
> >+ * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
> It might be worth noting down the update date here as well. The do not seem
> to have a version I can find easily so the update date might be a good idea
> to help helping looking at it to decide if we should update our code.
> 

ok.

- Alex
