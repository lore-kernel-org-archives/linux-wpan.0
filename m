Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A6ECAAD3
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 11:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiIELJs (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiIELJr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 07:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3212090
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662376185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nEXEVtoaWXOsBc1zkaqGL7x2YHKFdyVCidzzHZ70zQ8=;
        b=Cj7g5Vo7qf7mmCWgac3GildNy/mkitRFLYnRigsvyFMZ/q0gzgdmkN/WavxFJgZP/WWiiw
        UTxEx3b+1iU3Srayc/uZZCKRx6tfkvufsOlr1h47YreR3nHSJj/p9yTt3RO32Gk8mxauFV
        NZ7ftBSNUAcnD11Y5AVnGNQjv0+sW4I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-v1w8NJrGO_uJU-9hBlE68w-1; Mon, 05 Sep 2022 07:09:44 -0400
X-MC-Unique: v1w8NJrGO_uJU-9hBlE68w-1
Received: by mail-qt1-f198.google.com with SMTP id cm10-20020a05622a250a00b003437b745ccdso6657144qtb.18
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 04:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nEXEVtoaWXOsBc1zkaqGL7x2YHKFdyVCidzzHZ70zQ8=;
        b=noSEEbPFVtPgXhqjvf0jc75TPQ07A3XOq3ElmM87NKGGTmahnU/wq+O6S5xPEZGfOc
         dnMiW2OjtbZ1DfuSk2DKBTU6RZ3OO5NzDUG6yTYP2L2CkoWWgDaODYQknEzqoCovg22C
         7PyZRHI6qkMbY918b8mZ7amtJJsROFMvqkkZKgMKBVrbcNy+pC0hHkl0N35SHcQmOShh
         HvbrushWC9yPwEj8s+ukCQzM/2gq9bllRnCgoc3zHyvjH8Tto6CdRRlu7Rl44JsO6cYl
         GAFFnkwTmiq6PMIIbWp3Mc4ZluSC44pcQsiSYo53zdX/aa+mJ8+Z+40zcS8XVgDbZ1YS
         jlJA==
X-Gm-Message-State: ACgBeo0rgLOGyOMXoKt66jHDHXWcLKKtaN4o78Bj7grYckVJQd7i1acb
        ffUlBTj9j7sg55dTQAH1VhSOwY+5UzfLLz832AtctrIRfe3nQTy2Bm0KLBO3QTKF0A+AW1jZSjg
        wCTLkJ9lYKIq1lgesWo4xqQHRbYNA0zhL+bvlcA==
X-Received: by 2002:a05:6214:5086:b0:499:2979:2df4 with SMTP id kk6-20020a056214508600b0049929792df4mr18648567qvb.2.1662376184009;
        Mon, 05 Sep 2022 04:09:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40LlCzPm0j06tCOxeQoLBGI8u+Sm4EBXF2Ips8qCslrVuC8E8hyB6PpEsjFADNm30mOzq9yyn1uVCSdOaQ71c=
X-Received: by 2002:a05:6214:5086:b0:499:2979:2df4 with SMTP id
 kk6-20020a056214508600b0049929792df4mr18648557qvb.2.1662376183848; Mon, 05
 Sep 2022 04:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220905004944.967757-1-aahringo@redhat.com>
In-Reply-To: <20220905004944.967757-1-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 07:09:33 -0400
Message-ID: <CAK-6q+j6SbZ1_X8jqd8CuVSLqmE=t2jEOawv3rRkF3ip+gjbWg@mail.gmail.com>
Subject: Re: [RFC ben-wpan] fw: add trac reg to tx done
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, Sep 4, 2022 at 8:49 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> This patch adds an additional byte for tx done for the trac status
> register which can then evaluated by the atusb Linux driver.
> ---
>
> Just an RFC, need another weekend to test it.
>
>  atusb/fw/mac.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
> index 835002c..045d5fa 100644
> --- a/atusb/fw/mac.c
> +++ b/atusb/fw/mac.c
> @@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
>  static uint8_t tx_size = 0;
>  static bool txing = 0;
>  static bool queued_tx_ack = 0;
> -static uint8_t next_seq, this_seq, queued_seq;
> +static uint8_t next_seq, this_seq, queued_seq, queued_tx_trac;
>
>
>  /* ----- Receive buffer management ----------------------------------------- */
> @@ -57,6 +57,7 @@ static void tx_ack_done(void *user);
>  static void usb_next(void)
>  {
>         const uint8_t *buf;
> +       uint8_t data[2];
>
>         if (rx_in != rx_out) {
>                 buf = rx_buf[rx_out];
> @@ -65,7 +66,9 @@ static void usb_next(void)
>         }
>
>         if (queued_tx_ack) {
> -               usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
> +               data[0] = queued_seq;
> +               data[1] = queued_tx_trac;
> +               usb_send(&eps[1], data, sizeof(data), tx_ack_done, NULL);
>                 queued_tx_ack = 0;
>         }
>  }
> @@ -116,7 +119,7 @@ static void receive_frame(void)
>
>  static bool handle_irq(void)
>  {
> -       uint8_t irq;
> +       uint8_t irq, data[2];
>
>         irq = reg_read(REG_IRQ_STATUS);
>         if (!(irq & IRQ_TRX_END))
> @@ -124,10 +127,13 @@ static bool handle_irq(void)
>
>         if (txing) {
>                 if (eps[1].state == EP_IDLE) {
> -                       usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
> +                       data[0] = this_seq;
> +                       data[1] = reg_read(REG_TRX_STATE);
> +                       usb_send(&eps[1], data, sizeof(data), tx_ack_done, NULL);
>                 } else {
>                         queued_tx_ack = 1;
>                         queued_seq = this_seq;
> +                       queued_tx_trac = reg_read(REG_TRX_STATE);
>                 }
>                 txing = 0;

There is probably some race the trac register also have values stored
for RX_AACK_ON state which is being changed after the transmit but we
need at first to get the trac and then turn into RX_AACK_ON, so I
think the state change "change_state(TRX_CMD_RX_AACK_ON);" should be
moved after reading the trac.

- Alex

