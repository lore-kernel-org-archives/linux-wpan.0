Return-Path: <SRS0=nEeJ=3A=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC7EC33CA7
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Jan 2020 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DB62087F
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Jan 2020 23:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgAKXie (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Jan 2020 18:38:34 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48560 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbgAKXic (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Jan 2020 18:38:32 -0500
Received: by mail-io1-f69.google.com with SMTP id e15so3868779ioh.15
        for <linux-wpan@vger.kernel.org>; Sat, 11 Jan 2020 15:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=HG8PSEk+Nu2G0yzQ1sauBjh8yX4UWlbofl1tNDseMog=;
        b=dquS+RzddHuDM4udcrwhWbnpnJS3EZpqEPF2mq8wd0U571VvZ8B7+B77rgIRs68q4O
         KEcyJgaQH1jsjMR9vPaTQut3I/6gYjS/M3M8C8EJv0hyzQMCybL2e1uCKeVYtKnevIDr
         AyYvcXFbCo4DnXZEWbH/nvkBUzzuZX8bULbdnThl6ULAX4oqeVyJs5b8MxY7bdyNF1QT
         8B3q5Yraj1c+221ws+n5F4c1kUUh8ELGqaxWITSrMoAxJHVzeTkNrwh44VSCZmlYg9Tn
         Ig0aOYKEv3eaIDxSkXi3dCYD0gAG3rPis6wop0P1NKp4lmYPqZmKWY1sSF2Alb1kdwE5
         k0ZA==
X-Gm-Message-State: APjAAAXc6+FHVahmAiaCHKbnUa920cW0npGliqoknmRC+u/YzicMh4Co
        89+C8XQLsHp9sSiyJCZT+cn9l556hgouCh82Rz5L9TwIQzhr
X-Google-Smtp-Source: APXvYqzY3G/r7L2fdqmCj2j/h1C1sHPcBcM4PyU4coxfrfPzxUmQUqHGDBOKiBTJVPd2Dc1kvuMmxK6iFOuHlz4BJK9Zg+ciJv/g
MIME-Version: 1.0
X-Received: by 2002:a6b:c804:: with SMTP id y4mr7776396iof.210.1578785911931;
 Sat, 11 Jan 2020 15:38:31 -0800 (PST)
Date:   Sat, 11 Jan 2020 15:38:31 -0800
In-Reply-To: <CAM_iQpWN-SKjjrG_7EQ-x+7UMiu6foaNWMJuwQuwN0BGmayB+A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000751268059be5bdfc@google.com>
Subject: Re: Re: WARNING: bad unlock balance in __dev_queue_xmit
From:   syzbot <syzbot+ad4ea1dd5d26131a58a6@syzkaller.appspotmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, cleech@redhat.com,
        daniel@iogearbox.net, davem@davemloft.net, dsa@cumulusnetworks.com,
        f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, haiyangz@microsoft.com, info@metux.net,
        j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com,
        jhs@mojatatu.com, jiri@resnulli.us, johan.hedberg@gmail.com,
        johannes.berg@intel.com, john.hurley@netronome.com,
        jwi@linux.ibm.com, kstewart@linuxfoundation.org,
        kuznet@ms2.inr.ac.ru, kvalo@codeaurora.org, kys@microsoft.com,
        linmiaohe@huawei.com, linux-bluetooth@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        liuhangbin@gmail.com, marcel@holtmann.org,
        mareklindner@neomailbox.ch, mkubecek@suse.cz,
        mmanning@vyatta.att-mail.com, netdev@vger.kernel.org,
        nikolay@cumulusnetworks.com, oss-drivers@netronome.com,
        pabeni@redhat.com, paulus@samba.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

> #syz dup: WARNING: bad unlock balance in sch_direct_xmit

Your 'dup:' command is accepted, but please keep  
syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as  
a history of what happened with each bug report. Thank you.

