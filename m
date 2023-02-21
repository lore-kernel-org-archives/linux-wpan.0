Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB8C61DA3
	for <linux-wpan@archiver.kernel.org>; Tue, 21 Feb 2023 03:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjBUDGq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 22:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBUDGo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 22:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C1233F8
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676948757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BptwBvQo4kKBIsOLYiTztpRLcZRrp4WC3qd5w6Jr6p0=;
        b=N0gNpQeEuoISpxBVWyaDMYsHVfg8YTppfT1t2P7PfeGzlMNe6U3O6HtQflQnl95sM/5kbn
        n0TEf2zHXY64GuXCUWesP2jcYDwg2OCwFUIbh958yVEh9nB3UDwG5jlbOfHZD+cqWq5s1u
        LO9Pw1Z8LDqPME+68g2baLKFTtxW6fk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-kH9Tj_EVPOWHK-iQR6kseg-1; Mon, 20 Feb 2023 22:05:56 -0500
X-MC-Unique: kH9Tj_EVPOWHK-iQR6kseg-1
Received: by mail-ed1-f70.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so3058260edb.10
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 19:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BptwBvQo4kKBIsOLYiTztpRLcZRrp4WC3qd5w6Jr6p0=;
        b=tEICWFfsPVdWA/Camc2cJxmujymQY8X4dIkXu8TMh7+Rgf9YYaSUEL/U8i6K3qy9xQ
         HP+vd2/uzi8mP22u5W7nJ5HOmjC3H/StQeXtATypJIDz2nkReige7tC5eprwWZI0ZW5R
         C1BXe3VzvKG04vMwaUO79VHcZuTaJAMUOjEorUuHyBpchT/uoXZPkjY1wcwG7AjeH/Al
         dQVSFUkaN2Rq5mNVATSn8UjpIO5TjrKsJxA7rLC1cgerFDl92CxPa1cT/N/lEDVOC6G+
         vMdnfAWmOi5+WUHpOrrzNfc6RO8TXZ+Xthb6tJIJPNQzNdS6+IXyVBFZyRHI7uD30yhz
         96Fg==
X-Gm-Message-State: AO0yUKUiwNDWcJAqedUG1MDtr6iIJOpk3vXU0LqdGTua6jL31Z+pkeUQ
        Ds8yn5+rv6N6dyo/ia30J+hYlD5UwP7/BJfOkTHYIo2S5sjcfuqbEAOR1CSlhs6BGLmgXIoG6M9
        LdG7mWadPU5RlDC9rxbTis+dbK+PYpMn/axLQUA==
X-Received: by 2002:a17:906:5158:b0:883:ba3b:eb94 with SMTP id jr24-20020a170906515800b00883ba3beb94mr4978144ejc.3.1676948755273;
        Mon, 20 Feb 2023 19:05:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9jVHY4ucufPijCs6AjzBOPHfLncdKqZbq5tEHTs0STTs/YYj17Ofabhrxm4vpCviGQ73FfqHt6h/syeV5b/P0=
X-Received: by 2002:a17:906:5158:b0:883:ba3b:eb94 with SMTP id
 jr24-20020a170906515800b00883ba3beb94mr4978134ejc.3.1676948755047; Mon, 20
 Feb 2023 19:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+iwqVx+6qQ-ctynykdrbN+SHxzk91gQCSdYCUD-FornZA@mail.gmail.com>
 <20230206101235.0371da87@xps-13> <CAK-6q+jav4yJD3MsOssyBobg1zGqKC5sm-xCRYX1SCkH9GhmHw@mail.gmail.com>
 <20230210182129.77c1084d@xps-13> <CAK-6q+jLKo1bLBie_xYZyZdyjNB_M8JvxDfr77RQAY9WYcQY8w@mail.gmail.com>
 <20230213111553.0dcce5c2@xps-13> <CAK-6q+jP55MaB-_ZbRHKESgEb-AW+kN3bU2SMWMtkozvoyfAwA@mail.gmail.com>
 <20230214152849.5c3d196b@xps-13> <CAK-6q+i-QiDpFptFPwDv05mwURGVHzmABcEn2z2L9xakQwgw+w@mail.gmail.com>
 <20230217095251.59c324d0@xps-13> <CAK-6q+ikVP2eWpT5xRkiJn_JoenmD6D5+xcc2RwwXTfC-zsobw@mail.gmail.com>
In-Reply-To: <CAK-6q+ikVP2eWpT5xRkiJn_JoenmD6D5+xcc2RwwXTfC-zsobw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 20 Feb 2023 22:05:43 -0500
Message-ID: <CAK-6q+h6ZKvw5qR7yb2bvRrLvqUw0Mf5zVuh5-=fF5OgwJOr+A@mail.gmail.com>
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

On Mon, Feb 20, 2023 at 9:54 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Fri, Feb 17, 2023 at 3:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> ...
> > >
> > > ok, I am curious. Probably it is very driver/device specific but yea,
> > > HardMAC needs to at least support what 802.15.4 says, the rest is
> > > optional and result in -ENOTSUPP?
> >
> > TBH this is still a gray area in my mental model. I'm not sure what
> > these devices will really offer in terms of interfaces.
>
> ca8210 is one. They use those SAP-commands (MCPS-SAP and MLME-SAP)
> which are described by 802.15.4 spec... there is this cfg802154_ops
> structure which will redirect netlink to either SoftMAC or HardMAC it
> should somehow conform to this...
> However I think it should be the minimum functionality inside of this,
> there might be a lot of optional things which only SoftMAC supports.
> Also nl802154 should be oriented to this.
>
> Are you agreeing here?

it's just not nl802154/cfg802154 also sending specific kind of frames
out added to cfg802154 which we don't have yet inside of this
"callback structure to interfacing SoftMAC or HardMAC".

- Alex

