Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C2C38145
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiIFIIx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiIFII2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 04:08:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B05A2DB
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 01:08:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2F19BFF802;
        Tue,  6 Sep 2022 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662451702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/J+HsX9xYT8t+83YqLENG19ZHXr37jgoyygcb4QQ5s=;
        b=bIU5ERhjyf1JTMd4yaaI/AstqSIsUCM+GBFZifrmsTCI0/gIP5gekB0nZ9QSQ6FWrp9EuY
        SAh5vlYvZ2rk34d+nVYvRy5VSykpAMOB3NkwjMBMK6utVQ2ZJzQVVMiDRDBgZBBz0Sk5YJ
        xMtxZa+xviAETwZ3IbMcNAkWErzDAn+8RFLGA6l9L7uGjEpqRB2Eo9X+K6nSMn50HH6BUR
        DVjHYwS6wWRVvCL6mHurGDm+QerMhpQ8MZjDIoV3b8Zd99TOc7kZSBaBgW9AjXWyDevgcf
        zaRyO/2yiqvm4wWQTuLaIZDLphPoQLk85Z4lEnDjZlvm2gniiyLhdEtIUMR2fA==
Date:   Tue, 6 Sep 2022 10:08:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH atusb/fw 2/2] atusb: fw: Provide TRAC status
Message-ID: <20220906100818.3bed8aba@xps-13>
In-Reply-To: <CAK-6q+jdrk+5STNapcb=WX3vi8T-ucMSj3KDi8yB2WjGd93moQ@mail.gmail.com>
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
        <20220905204318.1324284-2-miquel.raynal@bootlin.com>
        <CAK-6q+jXWgEbZ_2kyOh-Jh4N1+d6owMbRn0e637MPMt+3+779g@mail.gmail.com>
        <CAK-6q+jdrk+5STNapcb=WX3vi8T-ucMSj3KDi8yB2WjGd93moQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Mon, 5 Sep 2022 20:19:28 -0400:

> Hi,
>=20
> On Mon, Sep 5, 2022 at 8:16 PM Alexander Aring <aahringo@redhat.com> wrot=
e:
> >
> > Hi,
> >
> > On Mon, Sep 5, 2022 at 4:43 PM Miquel Raynal <miquel.raynal@bootlin.com=
> wrote: =20
> > >
> > > From: Alexander Aring <aahringo@redhat.com>
> > >
> > > Upon Tx done condition, returning the sequence number is useful but we
> > > might also return the TRAC value which is needed to ensure that the
> > > packet we sent got ACKed. The TRAC register just needs to be read when
> > > the TRX_END interrupt fires.
> > >
> > > We then need to send this information as part of the status
> > > message. First byte remains the sequence number for ensuring backward
> > > compatibility and a second byte is added to forward the TRAC register
> > > status.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > [Miquel Raynal: Moved the data array out of the stack, wrote commit l=
og]
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> >
> > I sent another patch v2, it should also fix a race see commit msg
> > regarding RX_AACK_ON. May you can fast test it and feel welcome to
> > resubmit it as a patch.
> > This patch has a lot of generated/compiled files added and I think it
> > was an accident. =20

Crap.

> there are files which need to be added to ".gitignore". Just a hint,
> run "git add -u ." instead of "git add ." which will not add new
> files.

I didn't know about -u, I should probably get used to it because I too
often send generated files by mistake...

I initially wanted to add a .gitignore, and then forgot. I'll do it.

Thanks,
Miqu=C3=A8l
