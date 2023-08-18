Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CABC7112B
	for <linux-wpan@archiver.kernel.org>; Fri, 18 Aug 2023 09:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358926AbjHRJCz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359007AbjHRJCT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Aug 2023 05:02:19 -0400
X-Greylist: delayed 1502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:57 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941433C1E
        for <linux-wpan@vger.kernel.org>; Fri, 18 Aug 2023 02:01:57 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id CC2E2848C4; Fri, 18 Aug 2023 09:16:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346626; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=eykh6DNvQR+1ndCw/9BMV6/LGPFaeD+pogQnqj87NtNHfdqLiO/XmAIcmqr75DKe9
         kWXVhjaGupbevjRC2YFJPQOH+4DkWYCow0h0oI5sZUGMSowSgaki4yLUklY/gyic+d
         zmQKBRaNkXOiwc7UItEk5Ep+RRs1R1mHegv7HDzdE1/TFQWzz4YJ2pzVR1gr1mqLMH
         fVxgLCLMCEFDeClugQRPpsxG18Mn7T8ba5daKDtXhKugLz+8oomoEpUsgjAWlgFn+9
         DNbD9qP4gD9ZBRhh8hAgLRcqBSjRwfjbv63oifc0KlYE5meB4oL/GvlkG5eUbKbe0w
         fZ6ix4emmb3Vg==
Received: by mail.leachkin.pl for <linux-wpan@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cujm.0.l404s48k2q@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-wpan@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
