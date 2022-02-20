Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98224C433EF
	for <linux-wpan@archiver.kernel.org>; Sun, 20 Feb 2022 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiBTXcU (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 20 Feb 2022 18:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbiBTXcU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Feb 2022 18:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD009E34
        for <linux-wpan@vger.kernel.org>; Sun, 20 Feb 2022 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645399916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVO3Rr5UL6iYYrvPBeDVyYAqqdU9yg9+wE39qf4x+gg=;
        b=HNKve/4brwbz2Qf4yzm+dT+6WXC9vj+P71Fy4BUxfzZCAmrVd/HZK3RlBwTyCVPcuOfz6W
        G7GeJUg9o6MA51fKfXjCc4XhOloJb5YjNtkuCwuVkjnsEGUFMIQkkko0PYh3K9dLE+FtMF
        175uW636QX9QjrSq4qIP9rx/M/Z4G5Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-w43sJJnFPhy5n8kI3wOlzw-1; Sun, 20 Feb 2022 18:31:55 -0500
X-MC-Unique: w43sJJnFPhy5n8kI3wOlzw-1
Received: by mail-qv1-f71.google.com with SMTP id a12-20020a056214062c00b0042c2f3fca04so15210913qvx.21
        for <linux-wpan@vger.kernel.org>; Sun, 20 Feb 2022 15:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVO3Rr5UL6iYYrvPBeDVyYAqqdU9yg9+wE39qf4x+gg=;
        b=8PVHm3ZxhKjozKPcW8iQbnEkprFub9wtEkCBvhzrKEy6mNHrLD83ONTN0k0D5996E3
         sV4Cr0XAkOUMsAzLRRQgo0Hltv8pAtdY0Nj5sxI8+bkcfQxuFc0sy/0QNXPlBA+Zp9hF
         c9PEaxEswW7PbMJhG5tv0P+VKWY4pNuMT1GA1VN6tgewfXjBA2KwKRgkRpt5Cp4I5Z6m
         gGhBlztuUQzovEB8sDE0Sieg6JUfjOVLPim5fDuyXy32AVP8kJjN9MkiBxm1tvyKRsmg
         eqCcwsUUGbGQoizEM1Wl5zIhYQkjY7anKo1Nkj7kcplE6PZ1+rN+0odQL27pE8BQtzmX
         JTUA==
X-Gm-Message-State: AOAM530DsWzm3uriqb5Sd0MblIqNMtbt4jj/wQJMQcC1ftgoQXwHrOnz
        uyRay1J1OPe0cFBgbq1di6hThj7PA+at88hmt3frZlU5SAO+bWJAg2dDYpA+vTfIK3zbhuDCy4V
        BXAOpauuXUv9cdK3uzVAsQwHQRadtZ2UwuNwfOw==
X-Received: by 2002:a05:622a:203:b0:2de:64f:6231 with SMTP id b3-20020a05622a020300b002de064f6231mr4621759qtx.291.1645399915104;
        Sun, 20 Feb 2022 15:31:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY5mlnz93c/O6ggm+6il/aGAitsw1Yo+ElFz2WJUfVeaOm8nXDWUTWhwt8bbPMREushrAJPIBViuN7bt6Mxpk=
X-Received: by 2002:a05:622a:203:b0:2de:64f:6231 with SMTP id
 b3-20020a05622a020300b002de064f6231mr4621739qtx.291.1645399914877; Sun, 20
 Feb 2022 15:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20220207144804.708118-1-miquel.raynal@bootlin.com> <20220207144804.708118-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220207144804.708118-3-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 20 Feb 2022 18:31:44 -0500
Message-ID: <CAK-6q+iebK43LComxxjvg0pBiD_AK0MMyMucLHmeVG2zbHPErQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 02/14] net: mac802154: Create a transmit
 error helper
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Feb 7, 2022 at 10:09 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> So far there is only a helper for successful transmission, which led
> device drivers to implement their own handling in case of
> error. Unfortunately, we really need all the drivers to give the hand
> back to the core once they are done in order to be able to build a
> proper synchronous API. So let's create a _xmit_error() helper.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/mac802154.h | 10 ++++++++++
>  net/mac802154/util.c    | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 2c3bbc6645ba..9fe8cfef1ba0 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -498,4 +498,14 @@ void ieee802154_stop_queue(struct ieee802154_hw *hw);
>  void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
>                               bool ifs_handling);
>
> +/**
> + * ieee802154_xmit_error - frame transmission failed
> + *
> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> + * @skb: buffer for transmission
> + * @ifs_handling: indicate interframe space handling
> + */
> +void ieee802154_xmit_error(struct ieee802154_hw *hw, struct sk_buff *skb,
> +                          bool ifs_handling);
> +
>  #endif /* NET_MAC802154_H */
> diff --git a/net/mac802154/util.c b/net/mac802154/util.c
> index 6f82418e9dec..9016f634efba 100644
> --- a/net/mac802154/util.c
> +++ b/net/mac802154/util.c
> @@ -102,6 +102,16 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(ieee802154_xmit_complete);
>
> +void ieee802154_xmit_error(struct ieee802154_hw *hw, struct sk_buff *skb,
> +                          bool ifs_handling)
> +{
> +       unsigned int skb_len = skb->len;
> +
> +       dev_kfree_skb_any(skb);
> +       ieee802154_xmit_end(hw, ifs_handling, skb_len);
> +}

Remove ieee802154_xmit_end() function and just call to wake up the
queue here, also drop the "ifs_handling" parameter here.

- Alex

