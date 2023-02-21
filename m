Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF1BC636D6
	for <linux-wpan@archiver.kernel.org>; Tue, 21 Feb 2023 02:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjBUC71 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 21:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjBUC70 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 21:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7560FFF38
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676948320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUGVQQU8ha9dToISO+nXbL4NaXJXQDIYfr67WAN1gbY=;
        b=EO771WHcFVdkyFE0dneTFK9Jn9/p+ZvE0lTE2XbsewhAHkemM2dusfezM8fZzR6Vi+kiO0
        UD23DktyFPVjX8qSDR5YurXb8w25X5bvW74wf6SlApXkkI88zvJhmdBx/zvKAvRjEQAool
        cnyKYWvE3K5NLPHsO10jgF+iI/6asIc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-C7xE5A7yNZ-ZmfO8swUu9Q-1; Mon, 20 Feb 2023 21:58:39 -0500
X-MC-Unique: C7xE5A7yNZ-ZmfO8swUu9Q-1
Received: by mail-ed1-f71.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso3713877edb.7
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUGVQQU8ha9dToISO+nXbL4NaXJXQDIYfr67WAN1gbY=;
        b=TUaZmUjAwUKBehaKOzni5v5ZwCxMSYqbhhF62fxPym2Qgfblp3YoOWTHLS/EzccXSU
         FG4wbBgS0AX8w23HuSfqwUP0KCfHsYQ0Y+AN/OkxVu+FYzqp7JLs+TN7GNGQI1DMvPLu
         rOjUVM/PAaLhf+BvEeSRkMGNBG9ZIp4mTl+tDQECIBrr2OknnkPcv0QffGf9WWb0gPuq
         HeiKJ+0qnQYZCNn2VKfklvwXouh3SRz/l8KBaqlEnsU7yZIf7tH+UUd+jF8v7JvOp6Ym
         o14/Fylh/cHIMJokgna9fiMGtapkLaHfpDnWIHq80tUSW4Mr0zfXxCbZ2YbzjxkBn5cZ
         +G3Q==
X-Gm-Message-State: AO0yUKU+hl/jXRGdEmoIbl8kXwXE5sOyeTSrTHdf94ZzmOCuAmySM7Di
        kgWniuErGxQHWGRJBJL3Kh/FPYRkx716SaHDxlJ11EMJetLP/R05iul1GiT6ZZBzwEuVfsrXl8M
        MHdN7RUHU8VO80bioEC5EnEvni2I4UJ9DRZAGng==
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id e21-20020a170906249500b008b178b84207mr6514323ejb.3.1676948318204;
        Mon, 20 Feb 2023 18:58:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+CvuVTnLCeVgyoWH144+JTZH3cGPtR6y81s08i+zAv8rU14G3AI8BBjVFPQPoDXxX/nq2OI2Y5rnkTQoFU6Go=
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id
 e21-20020a170906249500b008b178b84207mr6514317ejb.3.1676948318004; Mon, 20 Feb
 2023 18:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20230218211317.284889-1-stefan@datenfreihafen.org>
 <20230218211317.284889-4-stefan@datenfreihafen.org> <20230220095944.6be3ceec@xps-13>
In-Reply-To: <20230220095944.6be3ceec@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 20 Feb 2023 21:58:26 -0500
Message-ID: <CAK-6q+h+o8DFV07oFLHPbPF5nM+gexQFUnFwsC7+Z6e8v8J8Mw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] MAINTAINERS: Add Miquel Raynal as additional
 maintainer for ieee802154
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        linux-kernel@vger.kernel.org, alan@signal11.us,
        liuxuenetmail@gmail.com, varkabhadram@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 4:01 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Stefan,
>
> stefan@datenfreihafen.org wrote on Sat, 18 Feb 2023 22:13:17 +0100:
>
> > We are growing the maintainer team for ieee802154 to spread the load for
> > review and general maintenance. Miquel has been driving the subsystem
> > forward over the last year and we would like to welcome him as a
> > maintainer.
>
> Thanks a lot!

welcome :)

- Alex

