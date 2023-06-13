Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2BBEB64D7
	for <linux-wpan@archiver.kernel.org>; Tue, 13 Jun 2023 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbjFMTZl (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMTZh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Jun 2023 15:25:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D041FCE
        for <linux-wpan@vger.kernel.org>; Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3d800f671so18146095ad.0
        for <linux-wpan@vger.kernel.org>; Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=Vuk5lprGVMjZyBqOAnxPZ1cP0qnAz1VOxXLVHd6COwWrk6uWeCNnFqJLd5ZlTB4xBN
         dzgZf7Jh9tixFAfZz3fmSPAlXZ/It7xgz3OZdv0ga4USAGY4venLvhA6oqd85Vcqq+o1
         kX6/a+xeL6i8dTiBdduqpe2IX31UD9Xg8A/SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=crMgZ2OT+RTZZBXGyTHzGMZICHFSvsPm/Jo6+jw/l4Qt5bXnK/WhOHwT/uZEvzbQNT
         FTvDukIWlQOv9Bs6rYJtZT+F7tEiVC5oLiBPAMTJB7Gi78yRGf7P78CP+PfCea8JtQxr
         S8XGK0FcHoYVISylQmrXMxSN3RPJh2eOmuDfadiMHn5UuR8p+f7ggupS66jkWtfWyj0e
         fuvHSMh52sViFlh8c+fz9O4WUIYuLZJbq06jhCmthfT7wiG77xOSxKwc7enrNg6cQw0w
         T57xtGe29m87Hd34LGJjaKuYKcEKgB9MAz3kDnNsmzM2y02GOIYVZ196VHG0iC8dW0QN
         3XMg==
X-Gm-Message-State: AC+VfDzP9Xnw+2QfaGKwCugKcicxxKJz9XL8yBHwI0KH2misF2LW3yAM
        ffZn5oH+c6IOfHJ5mnRGKYTnWQ==
X-Google-Smtp-Source: ACHHUZ7qXyztF8y1MkcPh+Rc6qnYC3E972aaXz8caME05mHnNSqufHjosMNobu5acZ7aPD5pnWR3Bg==
X-Received: by 2002:a17:902:e887:b0:1b0:f8:9b2d with SMTP id w7-20020a170902e88700b001b000f89b2dmr12528414plg.29.1686684325037;
        Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902f68a00b001a072aedec7sm10714545plg.75.2023.06.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:25:24 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:25:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-hardening@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: Replace strlcpy with strscpy
Message-ID: <202306131225.779997E@keescook>
References: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Tue, Jun 13, 2023 at 12:33:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since the return values
> from the helper macros are ignored by the callers.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
