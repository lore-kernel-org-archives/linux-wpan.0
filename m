Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E902E92FCD
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Oct 2023 04:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJFEHm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Oct 2023 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJFEHm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Oct 2023 00:07:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A64E7
        for <linux-wpan@vger.kernel.org>; Thu,  5 Oct 2023 21:07:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40535597f01so15242535e9.3
        for <linux-wpan@vger.kernel.org>; Thu, 05 Oct 2023 21:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696565257; x=1697170057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfmJdBPydu0BZJi6LE/RTqA11QEqZm0bT62TNJwMfLU=;
        b=rr70CsHtSYjU0JhuGFjffW8UqdVt7tisVHvQjKqRBq0ngNi2560ND07JBb+qwjAHuZ
         FTyXL1EfPNruFYt1199hZkF3Pc42WhFfSp8pFKkrg5ZauTM2rfd/H++JJ3JQnXfwM+85
         qfwUlLdsK96KiJn86HWiKTihhbNswz6n9ecgKERdqi/5UyFq8+6VigFSl+ajV1Alm2Zb
         ndm76/3PMRJc9uosUdccTwV4XMJw4hEhnYr9TkNoR04ixKiektOVp30QIxprJN7/7ojQ
         gFyqEPNYJCe1DVexm+scSgh7JUQZaQM2FeX9IKBF12mkqO82yEX0RHTWhBJzmYWvHgzK
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696565257; x=1697170057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfmJdBPydu0BZJi6LE/RTqA11QEqZm0bT62TNJwMfLU=;
        b=pTVIZhICN+S7/LYFjR8/eLu/1NxAj+nlGde0Kwfu6BxaAtmdvzUNYp2UAzsZFLbr+S
         9Pof9kpz3A5AUrz24lbkamR14qPNxDpzC95xDaCwDnSVRrVgs3lauyTIBJufK03WqQP3
         QIghplTQ/DZVQsog1L3/gzIw5/6J3IlJQOQRj6D42l4YMRaz1hbzlKuWMN8N4y0K9nC8
         0pIMw7Ll1oV6nEz+bDff4Bj02/5T4rMeUWmVYpx7TybGvQPLN2oTN4k7ePbGdLQeFHsG
         ZH3L8a9v2xUb/btskicvqHWOWMVwzULPOG9Dmm7A2048dITYA/zihZ5+amECctu4ELTj
         pjBg==
X-Gm-Message-State: AOJu0Yx8ZI+5Nhm9pIh5gKWT154L3bsGqOLKNW5Iq2UxjCzaz2cS3iFW
        5/Ni6qBAhTIAHGNvppw2EIy7TA==
X-Google-Smtp-Source: AGHT+IFjeXrQUs7p/saYuWWFYACMu2/fI8dWiPv6wIANSyumueY5p9GrWNrq8I5Iy/tR2cn2JV/ZzQ==
X-Received: by 2002:a05:600c:2117:b0:402:f55c:faee with SMTP id u23-20020a05600c211700b00402f55cfaeemr5918406wml.26.1696565257030;
        Thu, 05 Oct 2023 21:07:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b004064cd71aa8sm2784785wmj.34.2023.10.05.21.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:07:36 -0700 (PDT)
Date:   Fri, 6 Oct 2023 07:07:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
Message-ID: <e438fc67-665a-48b6-b414-0641821e0bf3@kadam.mountain>
References: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
 <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Thu, Oct 05, 2023 at 06:10:13PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Wed, Oct 4, 2023 at 5:22 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
> > free is a double free.
> >
> 
> lowpan_frag_rcv() does not call lowpan_invoke_rx_handlers(), it calls
> lowpan_invoke_frag_rx_handlers(), or is there something I overlooked
> here?

Actually now that I look at it more closely this isn't a bug.

The way I was looking at it was that it was the other way around.
lowpan_invoke_rx_handlers() is the caller.  But actually this returns
-1.  lowpan_invoke_rx_handlers() will pass the freed skb to
lowpan_rx_handlers_result() but the -1 gets translated to RX_DROP in
lowpan_rx_h_frag() then it just returns NET_RX_DROP.  It's a no-op and
not a double free.

Sorry!

regards,
dan carpenter

