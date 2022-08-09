Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72FC19F2D
	for <linux-wpan@archiver.kernel.org>; Tue,  9 Aug 2022 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiHIUWo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 9 Aug 2022 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiHIUWm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Aug 2022 16:22:42 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 13:22:40 PDT
Received: from mail.desertmonitor.com (desertmonitor.com [51.159.188.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89366193F2
        for <linux-wpan@vger.kernel.org>; Tue,  9 Aug 2022 13:22:40 -0700 (PDT)
Received: from [192.168.178.21] (p4fc3d4b3.dip0.t-ipconnect.de [79.195.212.179])
        by mail.desertmonitor.com (Postfix) with ESMTPSA id 88B0620D32
        for <linux-wpan@vger.kernel.org>; Tue,  9 Aug 2022 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=desertmonitor.com;
        s=mail; t=1660075994;
        bh=OrZJpsLNYvOJsD02tAIIM0YjGVBChRv3RolgegPfZ/E=;
        h=Date:To:From:Subject:From;
        b=avH2qSlgiNZKV02PUqIYGFh8QL3Z0Uy0SOTimZdh6GjqWHL0JCAS4i/meTM9Hs1Jj
         89MW+TFCvu7zYEToaYYrOigvPCTUPVm2MS9SSheygBTXRN2mhWyiDO1wfTpO3mWrrd
         3tvU9mMhzGmGn3td7kCAowrt95oCOTOzjMkV/gUPffWMXz9bQxZfg2yejfynp6XkAM
         2pdjSqrMLWATkxGY4Z+iHuI4TxW5WFPKwVu7qustkjjcljMYpuVd2PI8JaFBh+0yhu
         km+1ojXxGWiWYKv5lG3dD2BoADYvwno9I6fYpaMUh2FMRcbZMIob3jISdZD0S1T07p
         wrkewOydDrerw==
Message-ID: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
Date:   Tue, 9 Aug 2022 22:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     linux-wpan@vger.kernel.org
Content-Language: en-US
From:   Philipp Blum <info@desertmonitor.com>
Subject: 6LoWPAN (IPv6 over BLE) neighbor discovery
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hey,

I am currently working on a demonstration for the W3C TPAC next month. 
Just wanted to get an update on this topic, since RIOT uses it in IPv6 
over BLE.

best regards
Philipp Blum
