Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300FC433EF
	for <linux-wpan@archiver.kernel.org>; Tue, 17 May 2022 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbiEQNhC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiEQNhB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 09:37:01 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82813F1E;
        Tue, 17 May 2022 06:36:59 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D2E8C0003;
        Tue, 17 May 2022 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652794618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gs+93tEqOiIRId+H3tx8QpHdCxarKpqDBp7PI2qHNtY=;
        b=axifmMX/aGAptNFGfAhj7Nw3NhhJpa/B4CWUCYwvJOdWg9F15JGSi+7Df2NOCIdjUtFhOl
        86YAmmOlHJoaRHpR9z6zXgp/issATQbgvOH+lGcz6NChYOhKgtCml2Xq4dE5vkK8k0ckW9
        Iq+buJpd4JAqfFgwAJLXspVz/yyzVnIS3VkUMddVIywxZDM7VGThTlbjtrx5LhuVomh6yW
        7kOOced79amPblZcgQiOrp/8aw6Vpp3YD+ERSB16ICHxgYsb4B+38u86qUfhupG2gN2xK8
        tdDUdhgLUDqlaHvRVH+FqgNv35q791y7vPmBBJ9QnScZTYv4zG1XSHrQuX0jsA==
Date:   Tue, 17 May 2022 15:36:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v2 10/11] net: mac802154: Add a warning in the
 hot path
Message-ID: <20220517153655.155ba311@xps-13>
In-Reply-To: <CAK-6q+jYb7A2RzG3u7PJYKZU9D5A=vben-Wnu-3EsUU-rqGT2Q@mail.gmail.com>
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
        <20220512143314.235604-11-miquel.raynal@bootlin.com>
        <CAK-6q+jYb7A2RzG3u7PJYKZU9D5A=vben-Wnu-3EsUU-rqGT2Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


aahringo@redhat.com wrote on Sun, 15 May 2022 18:30:15 -0400:

> Hi,
> 
> On Thu, May 12, 2022 at 10:34 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > We should never start a transmission after the queue has been stopped.
> >
> > But because it might work we don't kill the function here but rather
> > warn loudly the user that something is wrong.
> >
> > Set an atomic when the queue will remain stopped. Reset this atomic when
> > the queue actually gets restarded. Just check this atomic to know if the
> > transmission is legitimate, warn if it is not.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/net/cfg802154.h |  1 +
> >  net/mac802154/tx.c      | 16 +++++++++++++++-
> >  net/mac802154/util.c    |  1 +
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index 8b6326aa2d42..a1370e87233e 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -218,6 +218,7 @@ struct wpan_phy {
> >         struct mutex queue_lock;
> >         atomic_t ongoing_txs;
> >         atomic_t hold_txs;
> > +       atomic_t queue_stopped;  
> 
> Maybe some test_bit()/set_bit() is better there?

What do you mean? Shall I change the atomic_t type of queue_stopped?
Isn't the atomic_t preferred in this situation?

