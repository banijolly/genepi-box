var App = angular.module('myApp', []);
App.controller("INSACOGdata", ["$scope", "$http", "$location", "$timeout", "$filter", function($scope, $http, $location, $timeout, $filter) {
    $scope.States = '';
//genome count start
	var method = 'GET';
           var url = './INSACOG/insacog-php/genomeCount.php';
            $http({
                method: method,
                url: url,
                headers: { 'Access-Control-Allow-Origin': true, 'Content-Type': 'application/x-www-form-urlencoded' },
            
            }).then(function(response) {
                  $scope.genomecount = response.data;
                  $scope.datalenght=$scope.genomecount;
           });


	//last 2 months data start
	var method = 'GET';

            var url = 'getLastMonthData.php';

            $http({

                method: method,

                url: url,

                headers: { 'Access-Control-Allow-Origin': true, 'Content-Type': 'application/x-www-form-urlencoded' },                             

            }).then(function(response) {

                                                         		

                $scope.state = response.data;

                state_data = response.data;

		var sumvalues = [];

                for (var i = 0; i < state_data.length; i++) {

                    sumvalues.push(state_data[i]['value']);

                }

                var sum = 0;
                for (var i = 0; i < sumvalues.length; i++) {

                    sum += sumvalues[i];

                }

                $scope.sumvalue= sum;

		        var pieCategories = [];



                var pieSeries = [];

                for (var i = 0; i < state_data.length; i++) {

                    

                    pieCategories.push(state_data[i]['hc-key']);

                

                }

                for (var key in state_data[0]) {

                    pieSeries.push({

                        name: key,

                        data: _.pluck(state_data,key),

                    });

                }

                Highcharts.chart('lastmonthgraph', {

                    chart: {

                        type: 'bar'

                    },

                    title: {

                        text: ''

                    },

                    subtitle: {

                        text: ''

                    },

                    xAxis: {

                        type: 'category',

                        categories: pieCategories,

                        labels: {

                        //    rotation: -45,

                            style: {

                                fontSize: '13px',

                                fontFamily: 'Verdana, sans-serif',
				color:'#000000',
    				textTransform: 'uppercase'

                            }

                        }

                    },

                    yAxis: {

                        min: 0,

                        title: {

                            text: 'NUMBER OF GENOMES'

                        }

                    },

                    legend: {

                        enabled: false,
			layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
	x: -40,
        y: 80,
        floating: true
			//reversed: true

                    },

                    

                    tooltip: {

                        headerFormat: '<b>{point.x}</b><br/>',

                    pointFormat: '{series.name}: {point.y}'

                    },
		    plotOptions: {

                        series: {

                            borderWidth: 0,

                            dataLabels: {

                                enabled: true,

                                format: '{point.y}'

                            }

                        }

                    },
                    series: pieSeries,

                });

            });
	//last 2 months data end

	var method = 'GET';
           var url = './INSACOG/insacog-php/statemongo.php';
            $http({
                method: method,
                url: url,
            //    data: ProductDataOne,
                headers: { 'Access-Control-Allow-Origin': true, 'Content-Type': 'application/x-www-form-urlencoded' },                             
            }).then(function(response) {
                                                         		
                   $scope.state = response.data;
                   state_data = response.data;

		var pieCategories = [];

                var pieSeries = [];
                for (var i = 0; i < state_data.length; i++) {
                    
                    pieCategories.push(state_data[i]['hc-key']);
                
                }

                for(i = 0; i < state_data.length; i++){
                    pieSeries.push({
                        name: state_data[i]['hc-key'],
                        y: state_data[i]['value']
                    });
                }

		//pie chart
		Highcharts.setOptions({
     			colors: ['#0D3D54', '#C02F1F', '#F16C21', '#EAC843', '#A2B86D', '#1295B9']
    		});
                Highcharts.chart('state_chart', {
                    chart: {
                        type: 'pie',
			 events: {
                          load() {
                            const chart = this;
                            chart.showLoading();
                            setTimeout(function() {
                              chart.hideLoading();
                            }, 1000);
                          }
                        }
                    },
                    title: {
                        text: 'Browser market shares in January, 2018'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    accessibility: {
                        point: {
                            valueSuffix: '%'
                        }
                    },
                
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            shadow: false,
                            center: ['50%', '50%'],
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.y}',
                                connectorColor: 'silver'
                            },
                            events:{
                            click: function(z) {
				if (z) { 
                                    $(".search").val(z.point.name);
				    $(".stateName").text(z.point.name);
                                    $scope.name = z.point.name;
                                    $scope.myFunc($scope.name);
				    $('html,body').animate({
               				  scrollTop: $(".lineage-card").offset().top},
               				'slow');
				     $scope.loading = true;
                                } 
                            },
                        }       
                        }
                    },
		    series: [{
                        name: '',
                        colorByPoint: true,
                        size: '80%',
                        innerSize: '60%',
                        data: pieSeries
                    }]
                });

		var data = [],
    arr_all_states = [
        "puducherry",
        "lakshadweep",
        "andaman and nicobar",
        "west bengal",
        "odisha",
        "bihar",
        "sikkim",
        "chhattisgarh",
        "tamil nadu",
        "madhya pradesh",
        "gujarat",
        "goa",
        "nagaland",
        "manipur",
        "arunanchal pradesh",
        "mizoram",
        "tripura",
        "daman and diu",
        "delhi",
        "haryana",
        "chandigarh",
        "himachal pradesh",
        "jammu and kashmir",
        "kerala",
        "karnataka",
        "dadara and nagar havelli",
        "maharashtra",
        "assam",
        "andhra pradesh",
        "meghalaya",
        "punjab",
        "rajasthan",
        "uttar pradesh",
        "uttarakhand",
        "jharkhand",
        "telangana",
        "ladakh"
        ];

	var arr_states_available = [];
    state_data.forEach(function(e){
        arr_states_available.push(e['hc-key']);
        data.push([e['hc-key'], e['value'], -1]);
    });
  
    arr_all_states.forEach(function(e){
        if (arr_states_available.indexOf(e) == -1) {
            data.push(
                [e, 0, 0, 0, 0, 0, -1]
            );
        }
    });

	Highcharts.mapChart('indiamap', {
        chart: {
            map: 'countries/in/custom/in-all-disputed'
        },
    
        title: {
            text: ''
        },
    
        subtitle: {
            text: ''
        },
    
        mapNavigation: {
            enabled: true,
            buttonOptions: {
                verticalAlign: 'bottom'
            }
        },
	colorAxis: [{
        min: 1000,
        max: 15000,
        endOnTick: true,
        startOnTick: false,
        stops: [
	    [0.001, '#DEF3F6'],
            [0.001, '#76ADE6'],
            [0.999, '#6246D9'],
            [0.999, '#3F2DA5']
	]
    }],
        series: [{
            data: data,
	    name: 'State',
            borderColor: '#FFF',
            states: {
                hover: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            dataLabels: {
               // enabled: true,
		//  format: '{point.name}'
		useHTML: true,
                allowOverlap: false,
		},
            events:{
                click: function(z) {
                    $scope.loading = true; 
                    if (z) { 
                    $("#search").val(z.point.name);
                    $(".stateName").text(z.point.name);
                        $scope.name = z.point.name;
                        $scope.myFunc($scope.name);
                
                     $('html,body').animate({
                     scrollTop: $(".lineage-card").offset().top},
                     'slow');
                    $scope.loading = true;
                    } 
                },
            }
        }]
    });
});

	$scope.myFunc = function(z) {
        if (z) { // if value is coming from example search
		$scope.name = z;

        }

	var ProductDataOne = {'Tag': $scope.tag};
            var ProductData = JSON.stringify(ProductDataOne);
            var method = 'POST';
            var url = 'php/loadData.php';
            $http({
                method: method,
                url: url,
                data: ProductDataOne,
                headers: { 'Access-Control-Allow-Origin': true, 'Content-Type': 'application/x-www-form-urlencoded' },
                
            }).then(function(response) {
                 $scope.content = response.data;
                 data = response.data;

		var sorted = data.sort(function(a,b) {
                    a = a.graph_data.split("-");
                    b = b.graph_data.split("-")
                    return new Date(a[1], a[0], 1) - new Date(b[1], b[0], 1)
                });

		var myCategories = [];

        var mySeries = [];
        for (var i = 0; i < data.length; i++) {
            
            myCategories.push(data[i]['graph_data']);
        
        }

	for (var key in data[0]) {
            if(key != "graph_data" && key != 'value'){
	  	if(key == "Other"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: 'gray'
                    });
                }
		if(key == "None"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#F0F0F0'
                    });
                }
                if(key == "B.1.1.7"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#209C94'
                    });
                }
                if(key == "B.1.351"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#E85300'
                    });
                }
                if(key == "B.1.617.2"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#A91376'
                    });
                }
                if(key == "P.1"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#741587'
                    });
                }
                if(key == "AY.1"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#004184'
                    });
                }
		if(key == "AY.2"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#FE8830'
                    });
                }
		if(key == "B.1.560"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#531489'
                    });
                }
		if(key == "AY.3"){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#D50800'
                    });
                }
		 if(key == "AY.20"){
		   mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                        color: '#D3EEBE'
                    });
                }
                if(key != 'Other' && key != 'None' && key != 'B.1.1.7' && key != 'B.1.351' && key != 'B.1.560' && key != 'B.1.617.2' && key != 'P.1' &&  key != 'AY.1' && key != 'AY.2' && key != 'AY.3' && key != 'AY.20'){
                    mySeries.push({
                        name: key,
                        data: _.pluck(data,key),
                    });
                }	
         
            }                      
        }

	$scope.loading = false;
        Highcharts.chart('lineageschart', {
           // colors:['#209C94','#E85300', '#F5FC02', '#741587', '#004184', '#FE8830', '#541487', '#F3B201', '#00850E', '#D50800', '#CEDE2D', '#A91376'],
            chart: {
                type: 'column',
		 events: {
                          load() {
                            const chart = this;
                            chart.showLoading();
                            setTimeout(function() {
                              chart.hideLoading();
                            }, 500);
                          }
                       }
            },
            title: {
                text: 'Stacked column chart'
            },
            xAxis: {
                categories: myCategories
            },
            yAxis: {
                min: 0,
                title: {
                    text: '% OF GENOMES'
                }
            },
            tooltip: {
                headerFormat: '<b>{point.x}</b><br/>',
		pointFormat: '{series.name}: {point.y}<br/>Total: ({point.percentage:.0f}%)'
		},
            plotOptions: {
                column: {
                    stacking: 'percent'
                },
                series: {
                   pointWidth: 40
               }
            },
            series: mySeries,
		responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            align: 'center',
                            verticalAlign: 'bottom',
                            layout: 'horizontal'
                        },
                        yAxis: {
                            labels: {
                                align: 'left',
                                x: 0,
                                y: -5
                            },
                            title: {
                                text: null
                            }
                        },
                        subtitle: {
                            text: null
                        },
                        credits: {
                            enabled: false
                        },
                        plotOptions: {
                            column: {
                                stacking: 'percent'
                            },
                            series: {
                               pointWidth: 15
                           }
                        },
                    }
                }]
            }
        });

    });

}

	var method = 'GET';
      var url = 'php/lineages.php';
      $http({
        method: method,
        url: url,
	headers: { 'Access-Control-Allow-Origin': true, 'Content-Type': 'application/x-www-form-urlencoded' },

      }).then(function(response) {
            $scope.state = response.data;
            lineage_data = response.data;

            $scope.lineagelenght = lineage_data.length;

        $(function() {
            var ms1 = $('#ms1').magicSuggest({

                value: ['B.1.1.7', 'B.1.351', 'B.1.617.2', 'B.1.1.529', 'P.1', 'BA.1', 'BA.2'],
                data: lineage_data
            });

            $(ms1).on('selectionchange', function(){
                $scope.tag = JSON.stringify(this.getValue());
                $scope.myFunc();
            });

            $scope.tag = JSON.stringify(ms1.getValue());
            $scope.myFunc();
            });
  });

}]);
