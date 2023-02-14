Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA673C61DA4
	for <linux-wpan@archiver.kernel.org>; Tue, 14 Feb 2023 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjBNN7K (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 14 Feb 2023 08:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBNN7J (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Feb 2023 08:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30F26CE5
        for <linux-wpan@vger.kernel.org>; Tue, 14 Feb 2023 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676383080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIEkIiVTqaVyY4OQ1tNP7iNR8iBTofvIDcc0iTg4IAs=;
        b=gumwZVZih9IVn4J4WwWswi8mNZEV3Tcw5XVVCXEYFcpXf6zi5D0P54SOvcZmF7IjTzm9xM
        6HdQ+j2g3V7PZ4ofrR9lnHbTkCHlrZC8HdNre4ZeFIAS8sF9ah2EyXKQjTJOgRhSJ7Urg+
        8FZZxBFpdRY7NrTDx3YWl/6GOTJpaaw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-y4XI52DTNhu4ZC0EhppioQ-1; Tue, 14 Feb 2023 08:54:09 -0500
X-MC-Unique: y4XI52DTNhu4ZC0EhppioQ-1
Received: by mail-ed1-f69.google.com with SMTP id y17-20020a056402359100b004acc4f8aa3fso4423739edc.3
        for <linux-wpan@vger.kernel.org>; Tue, 14 Feb 2023 05:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIEkIiVTqaVyY4OQ1tNP7iNR8iBTofvIDcc0iTg4IAs=;
        b=3nxBMgzY0/sf+ROOpzv+hV8lTjIFkJgBlWeoShwORdPD9rnl4OQGm+iLKm30yfSR+S
         54s9047m1IR88NKRkmL3PzEZhSQJCY3hmds/N1KSUTF6ICZ8VzFjtkj+OY6bvHQ8roit
         A2QpFo9J/ji8NhzKuUGGG/D5SIfko6OCiISEtybrai3vefsNdMf3ENYFsmSCv0ovX8l5
         9mhLN+GtuKtDGHXvDTiGp5ujRgHYiCaBdXplwU/TJaRnrFW3EPzSZL2dgRbYYiWTQqjY
         9HxLLzOF2/zPLxHlIBy0QoublYgn1oghhO4XL5tL3GA9mNCjsPy3bO78dU3OlEOAxU0d
         Zm5A==
X-Gm-Message-State: AO0yUKXsifEsw0lkW2OXvb6OJBdlYmCwIz6zr17z7uaKbbA+x+6JJfzx
        RZIqihnaTmqMiY7as3n0eS3+87kSbOU+873fnjwgX3pY1u0dHcg8p+wwoFwVbnc8By2orIEXbQ+
        nr4Zhf34m3xRyDCRZHiCnAm4HKDsI8gKtINlBDg==
X-Received: by 2002:a17:907:984a:b0:87b:dce7:c245 with SMTP id jj10-20020a170907984a00b0087bdce7c245mr1345471ejc.3.1676382848811;
        Tue, 14 Feb 2023 05:54:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+7hadw1dxMPAFu31dJ7JmuVakzkY4sOW+RpBc7shHyANZKavUEiC33+IZbiihrMjT6nOWLp3Dzp5k6Uq9pLL8=
X-Received: by 2002:a17:907:984a:b0:87b:dce7:c245 with SMTP id
 jj10-20020a170907984a00b0087bdce7c245mr1345456ejc.3.1676382848675; Tue, 14
 Feb 2023 05:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+iwqVx+6qQ-ctynykdrbN+SHxzk91gQCSdYCUD-FornZA@mail.gmail.com>
 <20230206101235.0371da87@xps-13> <CAK-6q+jav4yJD3MsOssyBobg1zGqKC5sm-xCRYX1SCkH9GhmHw@mail.gmail.com>
 <CAK-6q+jbcMZK16pfZTb5v8-jvhmvk9-USr6hZE34H1MOrpF=JQ@mail.gmail.com>
 <20230213183535.05e62c1c@xps-13> <CAK-6q+hkJpqNG9nO_ugngjGQ_q9VdLu+xDjmD09MT+5=tvd0QA@mail.gmail.com>
In-Reply-To: <CAK-6q+hkJpqNG9nO_ugngjGQ_q9VdLu+xDjmD09MT+5=tvd0QA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 14 Feb 2023 08:53:57 -0500
Message-ID: <CAK-6q+jU7-ETKeoM=MLmfyMUqywteBC8sUAndRF1vx0PgA+WAA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] ieee802154: Add support for user scanning requests
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Feb 14, 2023 at 8:34 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Feb 13, 2023 at 12:35 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Alexander,
> >
> > > > > > > +static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
> > > > > > > +{
> > > > > > > +       struct cfg802154_registered_device *rdev = info->user_ptr[0];
> > > > > > > +       struct net_device *dev = info->user_ptr[1];
> > > > > > > +       struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> > > > > > > +       struct wpan_phy *wpan_phy = &rdev->wpan_phy;
> > > > > > > +       struct cfg802154_scan_request *request;
> > > > > > > +       u8 type;
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       /* Monitors are not allowed to perform scans */
> > > > > > > +       if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > > > > > > +               return -EPERM;
> > > > > >
> > > > > > btw: why are monitors not allowed?
> > > > >
> > > > > I guess I had the "active scan" use case in mind which of course does
> > > > > not work with monitors. Maybe I can relax this a little bit indeed,
> > > > > right now I don't remember why I strongly refused scans on monitors.
> > > >
> > > > Isn't it that scans really work close to phy level? Means in this case
> > > > we disable mostly everything of MAC filtering on the transceiver side.
> > > > Then I don't see any reasons why even monitors can't do anything, they
> > > > also can send something. But they really don't have any specific
> > > > source address set, so long addresses are none for source addresses, I
> > > > don't see any problem here. They also don't have AACK handling, but
> > > > it's not required for scan anyway...
> > > >
> > > > If this gets too complicated right now, then I am also fine with
> > > > returning an error here, we can enable it later but would it be better
> > > > to use ENOTSUPP or something like that in this case? EPERM sounds like
> > > > you can do that, but you don't have the permissions.
> > > >
> > >
> > > For me a scan should also be possible from iwpan phy $PHY scan (or
> > > whatever the scan command is, or just enable beacon)... to go over the
> > > dev is just a shortcut for "I mean whatever the phy is under this dev"
> > > ?
> >
> > Actually only coordinators (in a specific state) should be able to send
> > beacons, so I am kind of against allowing that shortcut, because there
> > are usually two dev interfaces on top of the phy's, a regular "NODE"
> > and a "COORD", so I don't think we should go that way.
> >
> > For scans however it makes sense, I've added the necessary changes in
> > wpan-tools. The TOP_LEVEL(scan) macro however does not support using
> > the same command name twice because it creates a macro, so this one
> > only supports a device name (the interface command has kind of the same
> > situation and uses a HIDDEN() macro which cannot be used here).
> >
>
> Yes, I was thinking about scanning only.
>
> > So in summary here is what is supported:
> > - dev <dev> beacon
> > - dev <dev> scan trigger|abort
> > - phy <phy> scan trigger|abort
> > - dev <dev> scan (the blocking one, which triggers, listens and returns)
> >
> > Do you agree?
> >
>
> Okay, yes. I trust you.

btw: at the point when a scan requires a source address... it cannot
be done because then a scan is related to a MAC instance -> an wpan
interface and we need to bind to it. But I think it doesn't?

- Alex

