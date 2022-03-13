Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34200C433F5
	for <linux-wpan@archiver.kernel.org>; Sun, 13 Mar 2022 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiCMUSI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 13 Mar 2022 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCMUSH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 13 Mar 2022 16:18:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111358E194;
        Sun, 13 Mar 2022 13:16:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w27so23799593lfa.5;
        Sun, 13 Mar 2022 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lF/gT51FipGQcnByyIiiiOkhSTwd5tIlJbStSEDO4dc=;
        b=Z+XKo2KauQYTcbWNkQOMKquocTY9FaigJDyUhCJubz9GZdTDhtrOAy2FKDNDHzkCno
         X+H65DSeoMzv118hy3tulzJTOPc/vxp4+cxrRrw0ueXQsYtVJSMVoiO79in1sOFVFn6Q
         Pw5D33YoqaHkHWV7WEcMhFLt4PQqhk6qX2Fe2Mw7D1/k/EKGLi3RlwcXVWWhXd2birJP
         G3egDl9Ll0DhnoW6kUMr22K41IPW2+FUZBihh4GgFCvuoNSG9VjVgBIELlMr3vwYq/yG
         jKhW1NOLTj/8ZB/+XomLf5Yem6Ocv3ajk2aYN1wgVHcpxnp+Ia9lUwCWd1t1rPHp3gUh
         l5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lF/gT51FipGQcnByyIiiiOkhSTwd5tIlJbStSEDO4dc=;
        b=j8YLpD9IDg93hq+SCOyVGkfQH29SR4F+EFeny0jKOJzkvvFotINuoJrHMNnxod9lan
         pKgr9Ab70eDZGccvRZsJdYpUjfxN5wlJCY+/yrlZfjNQPjgg/aV3Emg9t/ftoVg4H8+W
         NfL2zM2lBVu04Gvn0uouylgQuB0rFLe7cpyD8vxgWsKwb3g5q6ygjHcJOUKTpbGa/hAj
         b4CA4PmSfItwBR07bdkgEsucfHRcrS1EWBgicBqtJ+BLHS8mrOizY6rydcnW5xetMAS2
         qlZ0w/V1Bn43TrLKG6rKHNK3Dd7k2r3pcilrnlc+GrseaYTjWfdT5s4LjXS1GvuJEFq3
         ktSA==
X-Gm-Message-State: AOAM5314WoKwmZn/Xk3jXyPjWJaU6mXFxotM7xH0G/8LTEMzF/Xex+EM
        EndTmtMTF+BDocE6mAe4t+bnph4e/r75WZjJ13U=
X-Google-Smtp-Source: ABdhPJyguvs3W/7mNkf3V34b5FXG9g6e0gflZW9ITN4H0ULRrAzhvoRc1OVkN4XtGS2577t8YhuBomz8brCi8pr/quc=
X-Received: by 2002:a05:6512:260e:b0:448:97b8:94b0 with SMTP id
 bt14-20020a056512260e00b0044897b894b0mr847711lfb.226.1647202616862; Sun, 13
 Mar 2022 13:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220303182508.288136-1-miquel.raynal@bootlin.com> <20220303182508.288136-8-miquel.raynal@bootlin.com>
In-Reply-To: <20220303182508.288136-8-miquel.raynal@bootlin.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Sun, 13 Mar 2022 16:16:45 -0400
Message-ID: <CAB_54W5f87H2umyRsjAZ--x_BiN8D7taG4BnyEXx1EWQyQSyBA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 07/11] net: ieee802154: at86rf230: Provide
 meaningful error codes when possible
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
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

On Thu, Mar 3, 2022 at 1:25 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Either the spi operation failed, or the device encountered an error. In
> both case, we know more or less what happened thanks to the spi call
> return code or the content of the TRAC register otherwise. Use them in
> order to propagate one step above the error.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/net/ieee802154/at86rf230.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 12ee071057d2..5f19266b3045 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -370,7 +370,27 @@ static inline void
>  at86rf230_async_error(struct at86rf230_local *lp,
>                       struct at86rf230_state_change *ctx, int rc)
>  {
> -       dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
> +       int reason;
> +
> +       switch (rc) {
> +       case TRAC_CHANNEL_ACCESS_FAILURE:
> +               reason = IEEE802154_CHANNEL_ACCESS_FAILURE;
> +               break;
> +       case TRAC_NO_ACK:
> +               reason = IEEE802154_NO_ACK;
> +               break;
> +       case TRAC_INVALID:
> +               reason = IEEE802154_SYSTEM_ERROR;
> +               break;
> +       default:
> +               reason = rc;
> +       }
> +

Actually the rc value here is not a TRAC status register value... and
it should not be one.

The reason is because this function can also be called during a non-tx
state change failure whereas the trac register is only valid when the
transmission "is successfully offloaded to device" and delivers us an
error of the transmission operation on the device. It is called during
the tx case only if there was a "state transition error" and then it
should report IEEE802154_SYSTEM_ERROR in
at86rf230_async_error_recover_complete(). Whereas I think we can use
IEEE802154_SYSTEM_ERROR as a non-specific 802.15.4 error code, because
a bus error of a state transition is not 802.15.4 specific.

- Alex
