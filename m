Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CBC001DB
	for <linux-wpan@archiver.kernel.org>; Thu, 10 Aug 2023 08:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjHJIfL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjHJIfK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Aug 2023 04:35:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058151BFB
        for <linux-wpan@vger.kernel.org>; Thu, 10 Aug 2023 01:35:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso5260625e9.2
        for <linux-wpan@vger.kernel.org>; Thu, 10 Aug 2023 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691656507; x=1692261307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM5c1fCe71bXjP+/DYMV8fSoBtFwccX2huN11PlbeTw=;
        b=rhsbavql8ZH5JMNDD60tdTd090g32uo+vMaRZiiW0SlZM5sGK+GkhcvSPSgZJZfvfd
         tw+Njzz3+RoZRDO7Yjr7xgvtFekWId6AEhTwHTSVzYA98ppF4HwRJWGHN8mwtzrYkK6l
         aHoxdv9WsZJaV+oRqveXjf3pYR1WtrCAsUcu5Kq9dq97PPeL1p80q5/9e0T+AUcosQei
         w0Fy96IoO+n/TB7kSBpvsu/Kw0zeTyKVTSoIWqrIeRg7+2KJdKw/65vsMDYh5dONSqW7
         KdUn4ZNluER1pGBvnYJSnd+0wqHvBvn9UP7CnVLFXD0bA+n77adBUb6208CDskdA709w
         dEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656507; x=1692261307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM5c1fCe71bXjP+/DYMV8fSoBtFwccX2huN11PlbeTw=;
        b=cvLJa3c/ziyt7humcWKnbVU9NMolOmFjKbNFrw6U8Lmbvk9Y2giG8sBGvKn31EOx+k
         Di3EuW+KmQ8Y9tJF76YLzrhGf57HTc1UjqPr16AoEvXhRSillpLGkH8zbIx5wRkubjbM
         wj+jwILLo3B/pnIdWbzMh9OAorXl56GTCgOkZKb0KrUdsgkm7+kT7sbBfPgBNmZV2fyZ
         +4xvBuF4o0HEwxdBKdW+PbI9EXLWlqy/iKN4yRBpKY8C/eY3xqPSS+IIV73eVM5Y0zPK
         dHznNH1dXLUw5tCTvrnyuZtSBXrYAiFOy1K5kaemm7C8CHSlWgoeYTdAohHXqDeqfT91
         vIJQ==
X-Gm-Message-State: AOJu0YzUvFqmJxgaWGitXaD49NmSgC8sLkGY0KHphDmMfwEuUsLbQBfd
        P4hzmKMeKWY59S855PBd7jsZ0w==
X-Google-Smtp-Source: AGHT+IHUOsbgm9S0hE6ryodK/ySL3LaoxEfx6NRd4v0M2koiBNPFLdL77ypCCq8yK8czVI+c7fvE3g==
X-Received: by 2002:a1c:7705:0:b0:3f9:c0f2:e1a4 with SMTP id t5-20020a1c7705000000b003f9c0f2e1a4mr1329391wmi.34.1691656506191;
        Thu, 10 Aug 2023 01:35:06 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b0031431fb40fasm1382078wrx.89.2023.08.10.01.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:35:05 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:35:04 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, johannes@sipsolutions.net, Jason@zx2c4.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, krzysztof.kozlowski@linaro.org,
        jmaloy@redhat.com, ying.xue@windriver.com, floridsleeves@gmail.com,
        leon@kernel.org, jacob.e.keller@intel.com,
        wireguard@lists.zx2c4.com, linux-wpan@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct genl_info
Message-ID: <ZNShOAs5oLBReCxC@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-6-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Wed, Aug 09, 2023 at 08:26:43PM CEST, kuba@kernel.org wrote:
>Since dumps carry struct genl_info now, use the attrs pointer
>use the attr pointer from genl_info and remove the one in
>struct genl_dumpit_info.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
