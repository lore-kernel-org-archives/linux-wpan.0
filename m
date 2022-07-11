Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FADC433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 11 Jul 2022 02:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiGKCCE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGKCCD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 10 Jul 2022 22:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE8018356
        for <linux-wpan@vger.kernel.org>; Sun, 10 Jul 2022 19:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657504922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtGmLvgMVrjBsXPDcs0lR3PF5YdXW4PPSQrac0ALdQg=;
        b=BN/pHZfjXwoeWkOqDmtRKC4UV43+5oa7KJIssXzNp87NlZGcj+5KPM+KP3q0dHYeEWnK/J
        XyiVdajN06YS6RpEPtcl8f+H8RyzYOqiQFL3Tj6cJplfTw7QQHPFyf9Ku71NPmtDRpLdBF
        S1H9Vf6AxlHZbYp2A776rqb5+oEz42s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-woFbfAdYPYCVznwH0fSyRg-1; Sun, 10 Jul 2022 22:01:55 -0400
X-MC-Unique: woFbfAdYPYCVznwH0fSyRg-1
Received: by mail-qk1-f198.google.com with SMTP id t203-20020a3746d4000000b006af1d3e8068so4188431qka.0
        for <linux-wpan@vger.kernel.org>; Sun, 10 Jul 2022 19:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtGmLvgMVrjBsXPDcs0lR3PF5YdXW4PPSQrac0ALdQg=;
        b=W5xtasK4Ct85/DWVlqDqSolh/UBXHnyYLE96/2AkOn+Zwy/3jmz3iX3ADodfXd5Cxc
         fM6G9JGZ3zB1FFnROtitkSyINfVXtfku/08HtXaCwrlAGxx915VAV0VvC4eTpouI+7sp
         AK7TL7NCjEbXBqPJUthp+LfewC35E9YAC2d9zp9gi9blpmzV5wtic7W7UHYTHANmbtfC
         p4mtqW5S6Kz8WHM8teqsDypGYK3OG2tfIMM0R8qMgNc+/L88GD9zKLChbOUFwAbDmWf6
         lDlIRHt3EWOjLKImefC59jg38E0+dBJ44UoaCd9cwHfIEKCypTj1wLPfER3PmqU+V6ia
         f/aw==
X-Gm-Message-State: AJIora/C80H4hSxfjugqUwWmSDBFlVF4wYnf4u/354ZUXH3AJMfnGe8v
        c9Tq6AdCnQ0uqx4wap3u1kg/xdqLleSR3hWuPqq9KMGXAfE2B/pQ4V6/nRGT6SSjtThYPuLvc1z
        UWOMZhyyVsQcGJHUxra1yVs2DlylQe5O/Kc8xyw==
X-Received: by 2002:a05:622a:130b:b0:31e:ac55:947f with SMTP id v11-20020a05622a130b00b0031eac55947fmr7143835qtk.339.1657504914540;
        Sun, 10 Jul 2022 19:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+4QWQAz9S6VUHnnj1EkcpLlFpZLIeLG0B9WpxwYNpoQl4l3EVvNJ4LX0kZkEJHfR5w5Y/o8qC5aPmwpO5N3M=
X-Received: by 2002:a05:622a:130b:b0:31e:ac55:947f with SMTP id
 v11-20020a05622a130b00b0031eac55947fmr7143824qtk.339.1657504914366; Sun, 10
 Jul 2022 19:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com> <20220701143052.1267509-21-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143052.1267509-21-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 10 Jul 2022 22:01:43 -0400
Message-ID: <CAK-6q+hS-6esVw7ebAsr8MoDDsEkorTLKVQupW1xoTZaawCHZA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 20/20] ieee802154: hwsim: Allow devices to be coordinators
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

On Fri, Jul 1, 2022 at 10:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> In order to be able to create coordinator interfaces, we need the
> drivers to advertize that they support this type of interface. Fill in
> the right bit in the hwsim capabilities to allow the creation of these
> coordinator interfaces.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index a5b9fc2fb64c..a678ede07219 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -776,6 +776,8 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
>         /* 950 MHz GFSK 802.15.4d-2009 */
>         hw->phy->supported.channels[6] |= 0x3ffc00;
>
> +       hw->phy->supported.iftypes |= BIT(NL802154_IFTYPE_COORD);

I think we can do that for more than one driver (except ca8210). What
about the other iftypes?

- Alex

