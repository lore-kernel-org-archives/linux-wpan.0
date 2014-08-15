Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:65339 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbaHOO7r (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 10:59:47 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so2367962wgh.1
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 07:59:46 -0700 (PDT)
Date: Fri, 15 Aug 2014 16:59:44 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140815145942.GB14922@omega>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
 <1408098592-13412-5-git-send-email-alex.aring@gmail.com>
 <9210baeb113a002cd095647bdde4808b.squirrel@webmail.itwm.fhg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9210baeb113a002cd095647bdde4808b.squirrel@webmail.itwm.fhg.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 04/12] mac802154: tx: remove kmalloc in xmit
 hotpath
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org

On Fri, Aug 15, 2014 at 04:56:08PM +0200, Phoebe Buckheister wrote:
> > This patch removes the kmalloc allocation for workqueue data. This patch
> > replace the kmalloc and use the control block of skb. The control block
> > have enough space and isn't use by any other layer in this case.
> >
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  net/mac802154/tx.c | 51
> > ++++++++++++++++++++++++---------------------------
> >  1 file changed, 24 insertions(+), 27 deletions(-)
> >
> > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > index d99e4f5..b6776ee 100644
> > --- a/net/mac802154/tx.c
> > +++ b/net/mac802154/tx.c
> > @@ -34,7 +34,7 @@
> >  /* IEEE 802.15.4 transceivers can sleep during the xmit session, so
> > process
> >   * packets through the workqueue.
> >   */
> > -struct xmit_work {
> > +struct wpan_xmit_cb {
> >  	struct sk_buff *skb;
> >  	struct work_struct work;
> >  	struct ieee802154_local *local;
> > @@ -42,43 +42,46 @@ struct xmit_work {
> >  	u8 page;
> >  };
> >
> > +static struct wpan_xmit_cb *wpan_xmit_cb(struct sk_buff *skb)
> > +{
> 
> Do add a BUILD_BUG_ON(sizeof(struct wpan_xmit_cb) > sizeof(skb->cb)) to
> make sure the struct will *always* fit, even if we choose to resize it for
> whatever reason.

Ok, thanks. I also add a inline to this function. Thanks.

- Alex
