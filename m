Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE031C6FD1F
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Mar 2023 18:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCPSGq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCPSGp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Mar 2023 14:06:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4DBDC6
        for <linux-wpan@vger.kernel.org>; Thu, 16 Mar 2023 11:06:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13so2494727pjh.0
        for <linux-wpan@vger.kernel.org>; Thu, 16 Mar 2023 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678990003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mCt8prfCSQ7oDsx1bTuDrvYgv/LfInuW8e+kaRN+58=;
        b=N7kAVSsQ2PohremsNoTkrBI76k1fo4dMkpIMDKU+nAYfLZWsQ7F29kyOiVeTJdYwZX
         Fd65aCXwSsf023/A96yZN403ncG2Q8IWQoinGlAomyWDPk79ic0Fpp+DHxUwB7utP5OV
         ZX4wSoTBTeEV9AAb5l1N8EFXjOHRnq7lhBgBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mCt8prfCSQ7oDsx1bTuDrvYgv/LfInuW8e+kaRN+58=;
        b=kZdQW9zCizlKK6w3Krl2YrIoLsWaDpmhD+o8Hf5JSMeyuHSDWQmi7kSRHZaLmUqgdJ
         WZQ7hFuBDEo+uP+HCvsT5Eusf2oloB5XQrsOfBghuTHEQF7oNtf+uJs8dUfMgU+Nm/pI
         AiImTF25P5FhxOzv4pwyFTSy2FdejjkKk2/KIKqyE1FusDCVXgw4ed2TmM9PCDk5brIi
         MNrcbdzJE9axTvfIbQyUY6Gzn1Vr50olh7bNPf7IWnrvLSO2YVtjzqKWfqG9ku5MZDgv
         E80TK154WfPrA/154QMTpxwnC2kJs/NIlL712XbCo1mAg7bsaDEypiLxJT7Pd9IFQ1jQ
         NkBg==
X-Gm-Message-State: AO0yUKXpEgX+dNnPR+T0CqKgX5fgh73rDJxB6qlTftKtkHttg2X7OCP5
        K/J/PCraVjiU7OdrfvbKEy/nMAeNIhTWF/g9DMK7cA==
X-Google-Smtp-Source: AK7set+M3yi0RkByN/JVYAXsavvcjHycEh223j6ZkIHzA6icQqmZXnmsToLX0ZkwVT+60lYsEynMe/S+6cJ5ovdwPBo=
X-Received: by 2002:a17:90a:5386:b0:237:9cbe:22ad with SMTP id
 y6-20020a17090a538600b002379cbe22admr1400389pjh.5.1678990002656; Thu, 16 Mar
 2023 11:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-12-joel@joelfernandes.org> <996f0981-98f4-5077-12b6-bb093bbd28be@datenfreihafen.org>
In-Reply-To: <996f0981-98f4-5077-12b6-bb093bbd28be@datenfreihafen.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 14:06:30 -0400
Message-ID: <CAEXW_YT-KEU-c6zUUEDPvBS=9HFmc1L6JeQiwXU-RfYR78sywA@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] mac802154: Rename kfree_rcu() to kvfree_rcu_mightsleep()
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Girault <david.girault@qorvo.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Aring <aahringo@redhat.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Thu, Mar 16, 2023 at 12:41=E2=80=AFPM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 15.03.23 19:18, Joel Fernandes (Google) wrote:
> > The k[v]free_rcu() macro's single-argument form is deprecated.
> > Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
> > is to avoid accidental use of the single-argument forms, which can
> > introduce functionality bugs in atomic contexts and latency bugs in
> > non-atomic contexts.
> >
> > The callers are holding a mutex so the context allows blocking. Hence
> > using the API with a single argument will be fine, but use its new name=
.
> >
> > There is no functionality change with this patch.
> >
> > Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   net/mac802154/scan.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > index 9b0933a185eb..5c191bedd72c 100644
> > --- a/net/mac802154/scan.c
> > +++ b/net/mac802154/scan.c
> > @@ -52,7 +52,7 @@ static int mac802154_scan_cleanup_locked(struct ieee8=
02154_local *local,
> >       request =3D rcu_replace_pointer(local->scan_req, NULL, 1);
> >       if (!request)
> >               return 0;
> > -     kfree_rcu(request);
> > +     kvfree_rcu_mightsleep(request);
> >
> >       /* Advertize first, while we know the devices cannot be removed *=
/
> >       if (aborted)
> > @@ -403,7 +403,7 @@ int mac802154_stop_beacons_locked(struct ieee802154=
_local *local,
> >       request =3D rcu_replace_pointer(local->beacon_req, NULL, 1);
> >       if (!request)
> >               return 0;
> > -     kfree_rcu(request);
> > +     kvfree_rcu_mightsleep(request);
> >
> >       nl802154_beaconing_done(wpan_dev);
> >
>
> I just saw that there is a v2 of this patch. My ACK still stands as for v=
1.
>
>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

Thanks! Applied the ack and will be taking it via the RCU tree as we discus=
sed.

 - Joel
