Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC647C6FA8F
	for <linux-wpan@archiver.kernel.org>; Thu, 24 Aug 2023 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjHXPTL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjHXPSk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Aug 2023 11:18:40 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 08:18:36 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22FE19B4;
        Thu, 24 Aug 2023 08:18:36 -0700 (PDT)
Received: from [192.168.2.51] (p5dd0dcba.dip0.t-ipconnect.de [93.208.220.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 88B29C03A4;
        Thu, 24 Aug 2023 17:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1692889393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RbA4Hzmbogps30G44qtaF2RIRLvuX4cRjMRVc/i1haA=;
        b=J0StBk/P2UW+kFTK7AYQdExrb+owhDBMjl3aZrfx5MUJ/6nkWDYBJIxBXwpYjnCf3OKJd1
        u5cDHfcOTyiI+682qC8e+dkYmezMaQUCEorSw+Af1dPdcqmJ6yCoZkwm2Kz1MOFbt51aBv
        DDsIPr91K8RIWiqI3HGkEsdRQZYQ9PR3mA+iVMQs9AUHCozl2soV/+R/z5W9W40sAOsJgs
        8E7Ost6qZ9WN67gRelct+gAMLgx0/dDDdF82yOC1sGSdFgS7bUFSaSZyHxqVYi38pRKVcj
        EImx0if6RSfqqAGX1+tB1sAzb8h2Q4Ji3SC4TQtCP6IkDPzVDG9vhvtkiaQrmg==
Message-ID: <40b9467b-a9e8-bff7-5291-6200fbe9dd34@datenfreihafen.org>
Date:   Thu, 24 Aug 2023 17:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>
Cc:     Christopher Friedt <chris@friedt.co>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Linux Plumber IoT micro conference call for submissions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

Chris Friedt and myself will host the fifth iteration of the IoT micro 
conference at Linux Plumbers in November this year.

We are still looking for speakers and discussion topics to round out the 
MC. Bluetooth and 802.15.4 being two of the usual suspects, we wanted to 
bring this to your attention. If you have an interesting topic you want 
to raise and discuss feel free to submit to the submission system before 
September 15th.

https://lpc.events/blog/current/index.php/2023/08/23/iot-mc-cfp/

regards
Chris & Stefan
