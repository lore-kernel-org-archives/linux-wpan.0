Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1328C43334
	for <linux-wpan@archiver.kernel.org>; Wed,  6 Jul 2022 01:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGFBvR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGFBvR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Jul 2022 21:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 641C01836F
        for <linux-wpan@vger.kernel.org>; Tue,  5 Jul 2022 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657072275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hp7gsG3siEwCoORcVc+/k95f8COHL9gt/q4HFlmoM8w=;
        b=HIkQNxuJ7SvJhpGebbk0dD1xW7iley3SYmtSJSopKB3TcdkZGuV7TmGqmgTFcgOukwlinw
        aDrseOI50cFPlHdlvqqB/1fDCcgb1gymLy3vD7jwiIBF/UeBgxY8ZqR8HNL/pgqOj65NS1
        WYTUbpH4bu3JZIN+hhEP51fl/d5/BK4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-pI3bM1r9NQuQtJLggZWf5w-1; Tue, 05 Jul 2022 21:51:14 -0400
X-MC-Unique: pI3bM1r9NQuQtJLggZWf5w-1
Received: by mail-qk1-f199.google.com with SMTP id a7-20020a37b107000000b006af3bc02282so13313200qkf.21
        for <linux-wpan@vger.kernel.org>; Tue, 05 Jul 2022 18:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hp7gsG3siEwCoORcVc+/k95f8COHL9gt/q4HFlmoM8w=;
        b=JS1EqCNaNGJaEkuEsZ0HwhOF6BNuSZ0la0qKvuYJtMF9yNwFwwKMb7DwgqKB1u01ry
         Im9m23oRfxV77acQsfL81UclLULmQRxRe3AmFA+A6wP6oGBmPhYkcek9BEH9fU/6iFkS
         aBOcS6AzPgp27wE1hgErL6pk4+pAIMkCNJSjsGZIZMzSOcEHLvvFN0YT48OvaclZV79T
         xXBDpXAHi/XoK/ywO+xd3/mX5CIuQQ+yHrGv923KcCrJ4UuyD16OPiBvIdixQo5Nm7/z
         xEK92tS6C557MK4IWKTcqTx3/d51OwMIhniAZt1AbSY/+YfovFvmVTJJopyB5Vouc66Q
         ovWA==
X-Gm-Message-State: AJIora8qVxqPwinYyT06z/8i5/zYTCBCct0Rt2gaiKj67xWDGaH6uAbd
        mi/W2cKBJGqxLA9muCO5HzWnpm2MOBJoTHskZLb5RZcs9ghstaYLIpnWiPmtBGIATrq4KeiLVpf
        5qsFMb4RkHMusO38sl6xBp7ReL7MjPnibUXr3vQ==
X-Received: by 2002:a05:620a:46ab:b0:6b1:6550:9062 with SMTP id bq43-20020a05620a46ab00b006b165509062mr24021072qkb.80.1657072273469;
        Tue, 05 Jul 2022 18:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1udiPqu4ScZLDvdAcr6A3M9CT5XQPGvq1z1I7uMA2eMMpNiCWkMGgYG7ZZrxS+dD40m/elR0b3tTs9PXcGO7Fk=
X-Received: by 2002:a05:620a:46ab:b0:6b1:6550:9062 with SMTP id
 bq43-20020a05620a46ab00b006b165509062mr24021067qkb.80.1657072273246; Tue, 05
 Jul 2022 18:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com> <20220701143052.1267509-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143052.1267509-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 5 Jul 2022 21:51:02 -0400
Message-ID: <CAK-6q+jkUUjAGqEDgU1oJvRkigUbvSO5SXWRau6+320b=GbfxQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 01/20] net: mac802154: Allow the creation of
 coordinator interfaces
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 10:36 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> As a first strep in introducing proper PAN management and association,
> we need to be able to create coordinator interfaces which might act as
> coordinator or PAN coordinator.
>
> Hence, let's add the minimum support to allow the creation of these
> interfaces. This might be restrained and improved later.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/iface.c | 14 ++++++++------
>  net/mac802154/rx.c    |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 500ed1b81250..7ac0c5685d3f 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -273,13 +273,13 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
>                 if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
>                         int ret;
>
> -                       /* TODO currently we don't support multiple node types
> -                        * we need to run skb_clone at rx path. Check if there
> -                        * exist really an use case if we need to support
> -                        * multiple node types at the same time.
> +                       /* TODO currently we don't support multiple node/coord
> +                        * types we need to run skb_clone at rx path. Check if
> +                        * there exist really an use case if we need to support
> +                        * multiple node/coord types at the same time.
>                          */
> -                       if (wpan_dev->iftype == NL802154_IFTYPE_NODE &&
> -                           nsdata->wpan_dev.iftype == NL802154_IFTYPE_NODE)
> +                       if (wpan_dev->iftype != NL802154_IFTYPE_MONITOR &&
> +                           nsdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR)
>                                 return -EBUSY;
>
>                         /* check all phy mac sublayer settings are the same.
> @@ -577,6 +577,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
>         wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
>
>         switch (type) {
> +       case NL802154_IFTYPE_COORD:
>         case NL802154_IFTYPE_NODE:
>                 ieee802154_be64_to_le64(&wpan_dev->extended_addr,
>                                         sdata->dev->dev_addr);
> @@ -636,6 +637,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
>         ieee802154_le64_to_be64(ndev->perm_addr,
>                                 &local->hw.phy->perm_extended_addr);
>         switch (type) {
> +       case NL802154_IFTYPE_COORD:
>         case NL802154_IFTYPE_NODE:
>                 ndev->type = ARPHRD_IEEE802154;
>                 if (ieee802154_is_valid_extended_unicast_addr(extended_addr)) {
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index b8ce84618a55..39459d8d787a 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -203,7 +203,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
>         }
>
>         list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> -               if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE)
> +               if (sdata->wpan_dev.iftype == NL802154_IFTYPE_MONITOR)
>                         continue;

I probably get why you are doing that, but first the overall design is
working differently - means you should add an additional receive path
for the special interface type.

Also we "discovered" before that the receive path of node vs
coordinator is different... Where is the different handling here? I
don't see it, I see that NODE and COORD are the same now (because that
is _currently_ everything else than monitor). This change is not
enough and does "something" to handle in some way coordinator receive
path but there are things missing.

1. Changing the address filters that it signals the transceiver it's
acting as coordinator
2. We _should_ also have additional handling for whatever the
additional handling what address filters are doing in mac802154
_because_ there is hardware which doesn't have address filtering e.g.
hwsim which depend that this is working in software like other
transceiver hardware address filters.

For the 2. one, I don't know if we do that even for NODE right or we
just have the bare minimal support there... I don't assume that
everything is working correctly here but what I want to see is a
separate receive path for coordinators that people can send patches to
fix it.

Thanks.

- Alex

