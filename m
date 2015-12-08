Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2on0065.outbound.protection.outlook.com ([207.46.100.65]:43201
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932431AbbLHPDK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 10:03:10 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449575525-23259-1-git-send-email-michael.hennerich@analog.com>
 <5666DD06.1080005@osg.samsung.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <5666EC31.1000608@analog.com>
Date: Tue, 8 Dec 2015 15:41:53 +0100
MIME-Version: 1.0
In-Reply-To: <5666DD06.1080005@osg.samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, alex.aring@gmail.com, stefan@datenfreihafen.org, marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On 12/08/2015 02:37 PM, Stefan Schmidt wrote:
> Hello.
>
> On 08/12/15 12:52, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>


>> +    ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
>> adf7242_isr,
>> +                    irq_type | IRQF_ONESHOT,
>> +                    dev_name(&spi->dev), lp);
>> +    if (ret)
>> +        goto err_hw_init;
>> +
>> +    disable_irq(spi->irq);
>> +
>> +    ret = ieee802154_register_hw(lp->hw);
>> +    if (ret)
>> +        goto err_hw_init;
>> +
>> +    dev_set_drvdata(&spi->dev, lp);
>> +
>> +    adf7242_debugfs_init(lp);
>
> Hmm, you want to have DEBUG_FS support always enabled? I was expecting
> to have it enabled behind a driver debug option as it should not be
> needed during normal usage. I also expected the firmware_verify function
> to be triggered from there but I don't have a string opinion on that one.
>
> The Kconfig setup misses a "depends on DEBUG_FS".


Well - most debugfs function have empty return -ENODEV function stubs in 
case CONFIG_DEBUG_FS is not set.
It was done to avoid the ifdef and depends mess.
So this can stay the way it is.


>
>
>
>> +
>> +    dev_info(&spi->dev, "mac802154 IRQ-%d registered\n", spi->irq);
>> +
>> +    return ret;
>> +
>> +    ieee802154_unregister_hw(lp->hw);
>> +err_hw_init:
>> +    mutex_destroy(&lp->bmux);
>> +    ieee802154_free_hw(lp->hw);
>> +
>> +    return ret;
>> +}
>> +
>> +static int adf7242_remove(struct spi_device *spi)
>> +{
>> +    struct adf7242_local *lp = spi_get_drvdata(spi);
>> +
>> +    if (!IS_ERR_OR_NULL(lp->debugfs_root))
>> +        debugfs_remove_recursive(lp->debugfs_root);
>> +
>> +    ieee802154_unregister_hw(lp->hw);
>> +    mutex_destroy(&lp->bmux);
>> +    ieee802154_free_hw(lp->hw);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id adf7242_of_match[] = {
>> +    { .compatible = "adi,adf7242", },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(of, adf7242_of_match);
>> +
>> +static const struct spi_device_id adf7242_device_id[] = {
>> +    { .name = "adf7242", },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(spi, adf7242_device_id);
>> +
>> +static struct spi_driver adf7242_driver = {
>> +    .id_table = adf7242_device_id,
>> +    .driver = {
>> +           .of_match_table = of_match_ptr(adf7242_of_match),
>> +           .name = "adf7242",
>> +           .owner = THIS_MODULE,
>> +           },
>> +    .probe = adf7242_probe,
>> +    .remove = adf7242_remove,
>> +};
>> +
>> +module_spi_driver(adf7242_driver);
>> +
>> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>> +MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
>> +MODULE_LICENSE("GPL");
>>
>
> Besides the question about having DEBUG_FS enabled by default I think
> this one is fine now to go in.
>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
>
> I will do some testing on the hardware later today and scream if
> something strange shows up.
>
> regards
> Stefan Schmidt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
