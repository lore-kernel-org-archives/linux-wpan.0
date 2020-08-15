Return-Path: <SRS0=s/WF=BZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE1C433DF
	for <linux-wpan@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5644A20639
	for <linux-wpan@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE2IyiDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgHOWFO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgHOVux (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FBC02B8F8
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2020 06:41:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s189so13430985iod.2
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2020 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M7Ud70YtlDlx0enjUdiOpi2MQqRFEA1vO5iFL76crIo=;
        b=RE2IyiDZS5mYE96fXxu37/Dh48NljslHwnTQdwNSLPZFIkEjMN8cq8V21rGVezSATU
         l2ETQ5fQ/dGauaxpiBkH4rlcZAJyF/WiTbkN9mISUZhFe16brUXDCbEOZur1ToY9xUCZ
         4+VmZJIYYY7yyWc5SCtoJzIYwDQPSfMx4wIiOBbnvWVyQ6AFBOJ+zY22eJhs3xaSbBez
         FFOslE+h/Kvm3/SluaJTVM2SqK21VCZF+UVSizFMi5PJDYUYeKvmngdp7OdLdqEWAQNg
         x/CMEpI4XCuRcBIxStTKyoHblZCXCFDcWTd83qIxY/rkoafYOyA3zxk3HL5JlDx9tGT0
         Mo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M7Ud70YtlDlx0enjUdiOpi2MQqRFEA1vO5iFL76crIo=;
        b=f/FAXRlGAd1j6+MZNJA+vwfy2E+N8jQHLxnikgkkjzsdDo31IlhIAgQJ5rSYkTcLZ0
         pnH8/WHLkTEZvWWXmFmxphVr0aDfnN+D3MFIpLFu0Jxjv5JpBPeacalyVA1i0wAMlE84
         iMzx1ZNlWevSgw4JWbNqDvkJSCLwlK9pjHdurQzLcCOcwcHAERhP24J0+Wu3dhmUST3U
         5Ihq7weL4qDKt5L0lOAOlOFfPwkH8pF9eZLsED/7RfLVS56XFE3/q2FZjbrCg/0ZkSCE
         xfW6lAy9fuOSkryLnT9YzySDoUd40MIBvm+dnLAFbql6w/knUXehf+idrQW4TaHiHk9r
         h3nw==
X-Gm-Message-State: AOAM532ccTjV+HIP6rIUikNf4OPF0cmwcfLVCrQTri5CNxaDOgvtNUfg
        1e0M5f2IGjordN7XxqqGxHrvNX1riNhPasT2eHNy2vvJofIBCg==
X-Google-Smtp-Source: ABdhPJxqaZG4QAFTXIjFGerF+Jr6On9+UKKQflloi0m4b7QxOeDzmnSn3idbqOeObVWXBvB0yD5Xd5b22Bhxv5GLS94=
X-Received: by 2002:a02:866d:: with SMTP id e100mr6914093jai.83.1597498874671;
 Sat, 15 Aug 2020 06:41:14 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Sat, 15 Aug 2020 09:41:03 -0400
Message-ID: <CAF4BF-SfVVKQJ6sMTqwbX7BWivuxEeXo4hndHOmS0a08b_B3qA@mail.gmail.com>
Subject: Linux Plumbers IoT Microconference
To:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

You, Me, & IoT Two is looking at abstracts until Aug 17!
If you are doing something fun with the #Linux community involving
#IoT, drop us an abstract.
Speaker gifts are still available and registration is free!
https://www.linuxplumbersconf.org/event/7/abstracts/
